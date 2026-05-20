const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const { AccessToken } = require('livekit-server-sdk');

const app = express();
app.use(cors());
app.use(express.json());

// --- LÝVEKÝT ÞÝFRELERÝ (KENDÝ ÞÝFRELERÝNÝ YAZ) ---
const LIVEKIT_API_KEY = "APIVrrERWikervP"; 
const LIVEKIT_API_SECRET = "12msuOmzfMseqydmqhsGh4BvyyOGga6vdB6nfBkBPU9B";


const pool = new Pool({
    host: 'postgres', 
    user: 'lummy_admin',
    password: 'LummySuperSecretPassword123!',
    database: 'lummy_database',
    port: 5432,
});

const initDB = async () => {
    try {
        await pool.query(`
            CREATE TABLE IF NOT EXISTS users (
                id SERIAL PRIMARY KEY,
                username VARCHAR(50) UNIQUE NOT NULL,
                avatar_url TEXT DEFAULT 'https://raw.githubusercontent.com/oesbey/myprojectforai/main/v2/assets/animations/png/payton.png',
                coin_balance INT DEFAULT 0,
                role VARCHAR(20) DEFAULT 'user',
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        `);
        console.log("? Veritabaný tablolarý hazýr!");
    } catch (err) {
        console.error("? Veritabaný hatasý:", err);
    }
};
initDB();

app.get('/api/test', (req, res) => {
    res.json({ basari: true, mesaj: "Lummy Backend Beyni týkýr týkýr çalýþýyor! ??" });
});

app.get('/api/users', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM users ORDER BY id DESC');
        res.json({ basari: true, kullanicilar: result.rows });
    } catch (err) {
        res.status(500).json({ basari: false, hata: err.message });
    }
});

app.get('/api/create-user/:username', async (req, res) => {
    const { username } = req.params;
    try {
        const result = await pool.query(
            'INSERT INTO users (username, coin_balance) VALUES ($1, $2) RETURNING *',
            [username, 1000] 
        );
        res.json({ basari: true, mesaj: `${username} baþarýyla oluþturuldu!`, kullanici: result.rows[0] });
    } catch (err) {
        res.status(500).json({ basari: false, hata: "Bu isimde biri zaten var veya hata oluþtu." });
    }
});

app.get('/api/add-coin/:username/:amount', async (req, res) => {
    const { username, amount } = req.params;
    try {
        const result = await pool.query(
            'UPDATE users SET coin_balance = coin_balance + $1 WHERE username = $2 RETURNING *',
            [parseInt(amount), username]
        );
        if(result.rows.length === 0) return res.json({ basari: false, mesaj: "Kullanýcý bulunamadý!" });
        res.json({ basari: true, mesaj: `${username} adlý kiþiye ${amount} coin eklendi!`, yeni_bakiye: result.rows[0].coin_balance });
    } catch (err) {
        res.status(500).json({ basari: false, hata: err.message });
    }
});

// ?? ÝÞTE DÜZELTÝLEN YER BURASI! (async ve await eklendi)
app.get('/api/get-token/:username/:roomName', async (req, res) => {
    const { username, roomName } = req.params;

    try {
        const at = new AccessToken(LIVEKIT_API_KEY, LIVEKIT_API_SECRET, {
            identity: username,
            name: username,
        });

        at.addGrant({ 
            roomJoin: true, 
            room: roomName, 
            canPublish: true, 
            canSubscribe: true 
        });

        // ELI5: "await" dedik, þifrelemenin bitmesini bekleyecek!
        const token = await at.toJwt();

        res.json({ basari: true, token: token, oda: roomName, kisi: username });
    } catch (err) {
        res.status(500).json({ basari: false, hata: "Bilet oluþturulamadý!" });
    }
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Lummy Backend ${PORT} portunda baþarýyla ayaða kalktý!`);
});