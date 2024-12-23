// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'AddGroupPage.dart';
import 'ResetPasswordPage.dart';
import 'SettingsPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amasya Üniversitesi',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(255, 21, 28, 40),
      ),
      home:
          const GroupListPage(), // Ana sayfa olarak GroupListPage'i belirledim
    );
  }
}

// Sohbet Ekranı
class ChatPage extends StatefulWidget {
  final String groupName;

  const ChatPage({super.key, required this.groupName});

  @override
  _ChatPageState createState() => _ChatPageState();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
      ),
      body: Center(
        child: Text('Sohbet Sayfası: $groupName'),
      ),
    );
  }
}

class _ChatPageState extends State<ChatPage> {
  List<String> messages = [];
  TextEditingController messageController = TextEditingController();

  // Mesaj gönderme fonksiyonu
  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add(messageController.text);
      });
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.groupName} '),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Align(
                    alignment:
                        Alignment.centerRight, // Mesajı sağa hizalamak için
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            255, 209, 17, 17), // Mesaj balonunun rengi
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        messages[index],
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(
            color: Colors.black, // Çizgi rengi
            thickness: 1, // Çizgi kalınlığı
            indent: 1, // Başlangıç boşluğu
            endIndent: 1, // Bitiş boşluğu
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Mesaj...',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromARGB(65, 163, 163, 163),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send,
                      color: Color.fromARGB(255, 255, 0, 34)),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Grup Listesi Ekranı
class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  _GroupListPageState createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  int _currentIndex = 1; // Varsayılan olarak "Gruplar" seçili

  // Sekmelere göre görüntülenecek sayfalar
  final List<Widget> _pages = [
    ProfilePage(), // Profil listesi ayrı bir widget
    GroupListPageContent(), // Grup listesi ayrı bir widget
    ClubsPageContent(), // Klüp listesi ayrı bir widget
    SettingsPage(
      darkTheme: true,
      onThemeChanged: (bool value) {},
    ), // Ayarlar listesi ayrı bir widget
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amasya Üniversitesi'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 17, 0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Profil Resmini sola hizalamak için Row widget'ı kullanıyoruz
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.jpeg',
                        width: 65.0,
                        height: 65.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 12.0), // Görsel ile metin arasına boşluk
                  const Text(
                    'Melisa Köklü',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    '232201065@ogrenci.amasya.edu.tr',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ayarlar'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      darkTheme: true,
                      onThemeChanged: (bool value) {},
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Haberler'),
              onTap: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => const NewsPage()),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.announcement_outlined),
              title: const Text('Duyurular'),
              onTap: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => const AnnouncementPage()),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Çıkış Yap'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),

      body: _pages[_currentIndex], // Geçerli sekmeye göre içerik değişimi
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Seçili sekmeyi güncelle
          });
        },
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Gruplar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Kulüpler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}

// Kulüp Listesi İçeriği
class ClubsPageContent extends StatefulWidget {
  const ClubsPageContent({super.key});

  @override
  _ClubsPageContentState createState() => _ClubsPageContentState();
}

class _ClubsPageContentState extends State<ClubsPageContent> {
  // Kulüp verileri
  final List<Map<String, String>> allClubs = [
    {'name': 'Tiyatro Kulübü', 'image': 'assets/theater.png'},
    {'name': 'Müzik Kulübü', 'image': 'assets/music.png'},
    {'name': 'Robotik Kulübü', 'image': 'assets/robotics.png'},
    {'name': 'Spor Kulübü', 'image': 'assets/sports.png'},
    {'name': 'Edebiyat Kulübü', 'image': 'assets/literature.png'},
  ];

  int visibleClubsCount = 3; // Görüntülenecek kulüp sayısı

  // "Takip Et" butonu durumunu tutacak
  final List<bool> followStatus = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Okul Kulüpleri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kulüpler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // Kulüp Kartları
            Expanded(
              child: ListView.builder(
                itemCount: visibleClubsCount,
                itemBuilder: (context, index) {
                  final club = allClubs[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    color: const Color.fromARGB(38, 176, 176, 176),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(club['image']!),
                            radius: 30,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              club['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                followStatus[index] = !followStatus[index];
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: followStatus[index]
                                  ? const Color.fromARGB(255, 150, 0, 0)
                                  : Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              followStatus[index]
                                  ? 'Takip Ediliyor'
                                  : 'Takip Et',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Daha Fazla Kulüp
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // Kulüp sayısını tüm listeye genişlet veya küçült
                    if (visibleClubsCount < allClubs.length) {
                      visibleClubsCount = allClubs.length;
                    } else {
                      visibleClubsCount = 3; // Eski haline döndür
                    }
                  });
                },
                child: Text(
                  visibleClubsCount < allClubs.length
                      ? 'Daha Fazla Kulüp'
                      : 'Daha Az Göster',
                  style: const TextStyle(
                    color: Color.fromARGB(221, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Profil sayfası
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: const Color.fromARGB(255, 12, 17, 25),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil Resmi
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: const AssetImage('assets/images/user.png'),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () {
                          // Profil resmi ekleme işlemi
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),

            // Ad Soyad (Değiştirilemez)
            const Text(
              "Ad Soyad:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const Text(
              "Melisa Köklü",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Divider(color: Colors.white54),

            // Mail Adresi (Değiştirilemez)
            const Text(
              "Mail Adresi:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const Text(
              "232201065@ogrenci.amasya.edu.tr",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Divider(color: Colors.white54),

            // Şifre Değiştirme
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.red),
              title: const Text("Şifreyi Değiştir",
                  style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Colors.white70, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                );
                // Şifre değiştirme işlemi
              },
            ),
            const Divider(color: Colors.white54),

            // Biyografi Alanı
            const Text(
              "Biyografi:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Buraya bir açıklama ekleyin...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),

            // Kaydet Butonu
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Değişiklikleri kaydetme işlemi
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Değişiklikleri Kaydet",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 20, 35, 60),
    );
  }
}

// Grup Listesi İçeriği
class GroupListPageContent extends StatefulWidget {
  const GroupListPageContent({super.key});

  @override
  State<GroupListPageContent> createState() => _GroupListPageContentState();
}

class _GroupListPageContentState extends State<GroupListPageContent> {
  final Map<String, dynamic> groups = {
    'Yerleşkeler': [
      {
        'name': 'Yeşilırmak Yerleşkesi',
        'image': 'assets/logo.jpeg',
        'children': [],
      },
      {
        'name': 'Milli Hakimiyet Yerleşkesi',
        'image': 'assets/logo.jpeg',
        'children': [],
      },
      {
        'name': 'İpekköy Yerleşkesi',
        'image': 'assets/logo.jpeg',
        'children': [],
      },
    ],
    'Fakülteler': [
      {
        'name': 'Mühendislik Fakültesi',
        'image': 'assets/logo.jpeg',
        'children': [], // Children eklendi
      },
      {
        'name': 'Eğitim Fakültesi',
        'image': 'assets/logo.jpeg',
        'children': [], // Children eklendi
      },
      {
        'name': 'Fen Edebiyat Fakültesi',
        'image': 'assets/logo.jpeg',
        'children': [], // Children eklendi
      },
    ],
    'Bölümler': [
      {
        'name': 'Mühendislik',
        'image': 'assets/logo.jpeg',
        'children': [
          {
            'name': 'Bilgisayar Mühendisliği',
            'image': 'assets/logo.jpeg',
            'children': [],
          },
          {
            'name': 'Makine Mühendisliği',
            'image': 'assets/logo.jpeg',
            'children': [],
          },
          {
            'name': 'Elektrik-Elektronik Mühendisliği',
            'image': 'assets/logo.jpeg',
            'children': [],
          },
        ],
      },
      {
        'name': 'Eğitim',
        'image': 'assets/logo.jpeg',
        'children': [], // Children eklendi
      },
      {
        'name': 'Sağlık',
        'image': 'assets/logo.jpeg',
        'children': [], // Children eklendi
      },
    ],
  };

  final List<String> expandedItems = [];

  void toggleExpand(String itemName) {
    setState(() {
      if (expandedItems.contains(itemName)) {
        expandedItems.remove(itemName);
      } else {
        expandedItems.add(itemName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: groups.keys.map((category) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            ..._buildCategoryItems(context, groups[category] as List<dynamic>),
          ],
        );
      }).toList(),
    );
  }

  List<Widget> _buildCategoryItems(BuildContext context, List<dynamic> items,
      {int level = 0}) {
    return items.map((item) {
      final bool isExpanded = expandedItems.contains(item['name']);
      final bool hasChildren = item['children'].isNotEmpty;

      return Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(item['image']),
              radius: 20,
            ),
            title: Padding(
              padding: EdgeInsets.only(left: level * 16.0),
              child: Text(
                item['name'],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            trailing: hasChildren
                ? Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey,
                  )
                : null,
            onTap: () {
              if (hasChildren) {
                toggleExpand(item['name']);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(groupName: item['name']),
                  ),
                );
              }
            },
          ),
          if (isExpanded)
            ..._buildCategoryItems(
              context,
              item['children'],
              level: level + 1,
            ),
        ],
      );
    }).toList();
  }
}

void main() {
  runApp(const MyApp());
}
