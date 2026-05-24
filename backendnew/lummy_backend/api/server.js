const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const { AccessToken } = require('livekit-server-sdk');
const path = require('path');
const session = require('express-session');
const bcrypt = require('bcryptjs'); // Şifre kriptolama motoru

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const LIVEKIT_API_KEY = "BURAYA_KEY_YAZILACAK"; 
const LIVEKIT_API_SECRET = "BURAYA_SECRET_YAZILACAK";

const pool = new Pool({
    host: 'postgres', 
    user: 'lummy_admin',
    password: 'LummySuperSecretPassword123!',
    database: 'lummy_database',
    port: 5432,
});

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use(session({
    secret: 'lummy-production-secret-key',
    resave: false,
    saveUninitialized: true
}));

// --- PRODUCTION VERİTABANI İNŞASI ---
const initDB = async () => {
    try {
        // DİKKAT: Yeni sisteme geçtiğimiz için eski ilkel tabloyu silip en gelişmişini kuruyoruz!
        await pool.query('DROP TABLE IF EXISTS users CASCADE;');
        
        // ELI5: Senin istediğin 19972501 ile başlayan otomatik sayaç!
        await pool.query('CREATE SEQUENCE IF NOT EXISTS lummy_id_seq START WITH 19972501;');

        await pool.query(`
            CREATE TABLE users (
                id SERIAL PRIMARY KEY,
                lummy_id BIGINT UNIQUE DEFAULT nextval('lummy_id_seq'),
                username VARCHAR(50) UNIQUE NOT NULL,
                password_hash VARCHAR(255) NOT NULL,
                auth_provider VARCHAR(20) DEFAULT 'local', -- google, apple için hazır yer
                avatar_url TEXT DEFAULT 'https://raw.githubusercontent.com/oesbey/myprojectforai/main/v2/assets/animations/png/payton.png',
                coin_balance INT DEFAULT 0,
                level INT DEFAULT 1,
                role VARCHAR(20) DEFAULT 'user',
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
            CREATE TABLE IF NOT EXISTS rooms (
                id SERIAL PRIMARY KEY,
                owner_id INT REFERENCES users(id) ON DELETE CASCADE,
                room_name VARCHAR(100) UNIQUE NOT NULL,
                room_type VARCHAR(50) DEFAULT 'sohbet',
                is_active BOOLEAN DEFAULT true,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        `);
        
        // Sistemin ilk süper adminini otomatik oluşturalım (Şifre: 123456)
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash("123456", salt);
        await pool.query(`
            INSERT INTO users (lummy_id, username, password_hash, role) 
            VALUES (1, 'Admin', $1, 'superadmin') ON CONFLICT (username) DO NOTHING;
        `, [hash]);

        console.log("✅ Production Veritabanı Mimarisi Hazır!");
    } catch (err) {
        console.error("❌ Veritabanı hatası:", err);
    }
};
initDB();

// ==========================================
// ADMIN PANELİ (WEB) ROTALARI
// ==========================================

app.get('/admin', (req, res) => {
    if (req.session.admin) return res.redirect('/admin/dashboard');
    res.render('login', { error: null }); 
});

app.post('/admin/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        const result = await pool.query("SELECT * FROM users WHERE username = $1 AND role IN ('superadmin', 'admin')", [username]);
        if (result.rows.length > 0) {
            const user = result.rows[0];
            const isValid = await bcrypt.compare(password, user.password_hash);
            if (isValid) {
                req.session.admin = user; 
                return res.redirect('/admin/dashboard');
            }
        }
        return res.render('login', { error: 'Yetkisiz hesap veya hatalı şifre!' });
    } catch (error) {
        return res.render('login', { error: 'Veritabanı hatası.' });
    }
});

app.get('/admin/dashboard', async (req, res) => {
    if (!req.session.admin) return res.redirect('/admin'); 
    try {
        const userCount = await pool.query('SELECT COUNT(*) FROM users');
        const users = await pool.query('SELECT * FROM users ORDER BY id DESC');
        res.render('dashboard', { 
            admin: req.session.admin, 
            toplamUser: userCount.rows[0].count,
            usersList: users.rows 
        }); 
    } catch (error) { res.send("Hata oluştu."); }
});

// ADMIN İŞLEMİ: KULLANICI GÜNCELLE (Lummy ID, Level, Coin)
app.post('/admin/user/edit', async (req, res) => {
    if (!req.session.admin) return res.redirect('/admin');
    const { id, lummy_id, coin_balance, level, role } = req.body;
    try {
        await pool.query(
            'UPDATE users SET lummy_id=$1, coin_balance=$2, level=$3, role=$4 WHERE id=$5',
            [lummy_id, coin_balance, level, role, id]
        );
        res.redirect('/admin/dashboard');
    } catch (error) { res.send("Güncelleme hatası: " + error.message); }
});

// ADMIN İŞLEMİ: KULLANICI SİL
app.post('/admin/user/delete', async (req, res) => {
    if (!req.session.admin) return res.redirect('/admin');
    const { id } = req.body;
    try {
        await pool.query('DELETE FROM users WHERE id=$1', [id]);
        res.redirect('/admin/dashboard');
    } catch (error) { res.send("Silme hatası."); }
});

app.get('/admin/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/admin');
});

// ==========================================
// FLUTTER GERÇEK (CANLI) API LİNKLERİ
// ==========================================

// 1. KAYIT OL API
app.post('/api/auth/register', async (req, res) => {
    const { username, password } = req.body;
    try {
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(password, salt);
        
        const result = await pool.query(
            'INSERT INTO users (username, password_hash) VALUES ($1, $2) RETURNING id, lummy_id, username, coin_balance, level',
            [username, hash]
        );
        res.json({ basari: true, mesaj: "Kayıt başarılı", kullanici: result.rows[0] });
    } catch (error) {
        res.json({ basari: false, mesaj: "Bu kullanıcı adı zaten alınmış!" });
    }
});

// 2. GİRİŞ YAP API
app.post('/api/auth/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        const result = await pool.query('SELECT * FROM users WHERE username = $1', [username]);
        if (result.rows.length > 0) {
            const user = result.rows[0];
            const isValid = await bcrypt.compare(password, user.password_hash);
            if (isValid) {
                // Şifreyi siliyoruz ki telefona gitmesin (Güvenlik)
                delete user.password_hash;
                return res.json({ basari: true, kullanici: user });
            }
        }
        res.json({ basari: false, mesaj: "Hatalı kullanıcı adı veya şifre!" });
    } catch (error) { res.json({ basari: false, mesaj: "Giriş hatası!" }); }
});

// LIVEKIT TOKEN ALMA (Artık güvenli)
app.get('/api/get-token/:username/:roomName', async (req, res) => {
    try {
        const at = new AccessToken(LIVEKIT_API_KEY, LIVEKIT_API_SECRET, { identity: req.params.username, name: req.params.username });
        at.addGrant({ roomJoin: true, room: req.params.roomName, canPublish: true, canSubscribe: true });
        const token = await at.toJwt();
        res.json({ basari: true, token: token });
    } catch (err) { res.status(500).json({ basari: false }); }
});

app.listen(3000, () => console.log(`Lummy Production Backend 3000 portunda çalışıyor!`));