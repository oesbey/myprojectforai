import 'package:flutter/material.dart';
import 'package:runo_live/features/discover/models/discover_models.dart';
import 'package:runo_live/features/discover/screens/story_view_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  // SAHTE HİKAYE VERİLERİ (Orijinal kaliteli profil resimleri geri geldi!)
  final List<StoryModel> stories = [
    StoryModel(
        id: "0",
        userName: "Ben",
        avatarUrl: "https://i.pravatar.cc/150?img=11",
        imageUrls: []),
    StoryModel(
        id: "1",
        userName: "CINDY",
        avatarUrl:
            "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=400&fit=crop",
        imageUrls: [
          "https://picsum.photos/seed/story1/400/800",
          "https://picsum.photos/seed/story2/400/800"
        ]),
    StoryModel(
        id: "2",
        userName: "Asel",
        avatarUrl:
            "https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=400&fit=crop",
        imageUrls: ["https://picsum.photos/seed/story3/400/800"]),
    StoryModel(
        id: "3",
        userName: "Kartal",
        avatarUrl:
            "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=400&fit=crop",
        imageUrls: ["https://picsum.photos/seed/story4/400/800"]),
  ];

  // SAHTE GÖNDERİ VERİLERİ
  final List<PostModel> posts = [
    PostModel(
        id: "1",
        userName: "LUMMY Etkinlik",
        avatarUrl: "https://i.pravatar.cc/150?img=60",
        level: "59",
        contentText:
            "🇹🇷 ✨ 19 MAYIS ATATÜRK'Ü ANMA, GENÇLİK VE SPOR BAYRAMI ÖZEL ETKİNLİĞİ ✨ 🇹🇷\n\nBağımsızlığın ilk adımı...",
        // Gönderi resimleri için güvenli linkler kullanıyoruz (404 vermesin diye)
        imageUrls: [
          "https://picsum.photos/seed/post1/500/400",
          "https://picsum.photos/seed/post2/500/400"
        ],
        date: "2026/05/18",
        likeCount: 269,
        commentCount: 104,
        isPinned: true),
    PostModel(
        id: "2",
        userName: "CINDY",
        avatarUrl:
            "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=400&fit=crop",
        level: "63",
        contentText:
            "Sevgisi yetmeyen insanların bahanesi çok olur. Sen sürpriz beklersin, o 'Ben sürprizlerden anlamam' der... 🖤",
        imageUrls: ["https://picsum.photos/seed/post3/600/400"],
        date: "2026/05/18",
        likeCount: 52,
        commentCount: 8),
    PostModel(
        id: "3",
        userName: "Gamze",
        avatarUrl:
            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=400&fit=crop",
        level: "12",
        contentText: "Yeni profil çerçevemi nasıl buldunuz? 🥰",
        imageUrls: [], // Sadece metin postu
        date: "1 saat önce",
        likeCount: 15,
        commentCount: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: _buildAppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildStoryBar()),
          SliverToBoxAdapter(
              child: Divider(
                  color: Colors.grey.shade300, thickness: 1, height: 1)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildPostCard(posts[index]),
              childCount: posts.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00E5FF),
        child: const Icon(Icons.edit_square, color: Colors.white),
      ),
    );
  }

  // --- ÜST BAR ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            const Text("Arkadaşlarım",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(width: 15),
            Text("Keşfet",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
            const SizedBox(width: 15),
            Text("Oda üyeleri",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
          ],
        ),
      ),
      actions: [
        IconButton(
            icon: const Icon(Icons.notifications_none,
                color: Colors.black, size: 28),
            onPressed: () {}),
      ],
    );
  }

  // --- HİKAYELER ÇUBUĞU ---
  Widget _buildStoryBar() {
    return Container(
      color: Colors.white,
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          if (index == 0) {
            return _buildAddStoryBtn(story);
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoryViewScreen(story: story)));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient:
                          LinearGradient(colors: [Colors.orange, Colors.pink]),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(story.avatarUrl),
                        onBackgroundImageError: (exception,
                            stackTrace) {}, // Resim yüklenmezse çökmez
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 65,
                    child: Text(
                      story.userName,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddStoryBtn(StoryModel story) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 31,
                backgroundImage: NetworkImage(story.avatarUrl),
                onBackgroundImageError: (exception, stackTrace) {},
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2)),
                child: const Icon(Icons.add, color: Colors.white, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text("Hikayen",
              style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  // --- GÖNDERİ KARTI ---
  Widget _buildPostCard(PostModel post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(post.avatarUrl),
                onBackgroundImageError: (exception, stackTrace) {},
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            post.userName,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (post.isPinned) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.push_pin,
                              color: Colors.teal, size: 14),
                          const Text(" Sabitlendi",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ]
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.pinkAccent.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Icon(Icons.female,
                              color: Colors.pinkAccent, size: 12),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const Icon(Icons.military_tech,
                                  color: Colors.white, size: 10),
                              const SizedBox(width: 2),
                              Text(post.level,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.more_horiz, color: Colors.grey),
                  onPressed: () {}),
            ],
          ),
          const SizedBox(height: 12),
          Text(post.contentText,
              style: const TextStyle(fontSize: 14, color: Colors.black87)),
          const SizedBox(height: 12),
          if (post.imageUrls.isNotEmpty) _buildPostImages(post.imageUrls),
          const SizedBox(height: 12),
          Text(post.date,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.favorite_border,
                  color: Colors.black87, size: 22),
              const SizedBox(width: 6),
              Text("${post.likeCount}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87)),
              const SizedBox(width: 20),
              const Icon(Icons.chat_bubble_outline,
                  color: Colors.black87, size: 20),
              const SizedBox(width: 6),
              Text("${post.commentCount}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15)),
                child: const Row(
                  children: [
                    Icon(Icons.mark_chat_unread_outlined,
                        size: 16, color: Colors.black87),
                    SizedBox(width: 4),
                    Text("Sohbet",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // --- GÖNDERİ RESİMLERİ ---
  Widget _buildPostImages(List<String> images) {
    if (images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          images[0],
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: const Icon(Icons.image_not_supported,
                color: Colors.grey, size: 40),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 150,
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  images[0],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  images[1],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey)),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
