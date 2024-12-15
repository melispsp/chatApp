// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'AddGroupPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amasya Üniversitesi',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(255, 21, 28, 39),
      ),
      home:
          const GroupListPage(), // Ana sayfa olarak GroupListPage'i belirledim
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
    Center(
        child: Text('Profil Sayfası', style: TextStyle(color: Colors.white))),
    GroupListPageContent(), // Grup listesi burada ayrı bir widget olarak tanımlandı
    ClubsPageContent(),
    Center(
        child: Text('Ayarlar Sayfası', style: TextStyle(color: Colors.white))),
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
                color: Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Profil Resmini sola hizalamak için Row widget'ı kullanıyoruz
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/user.png',
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
                Navigator.pop(context);
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
            // Kulüp Listesi
            Expanded(
              child: ListView.builder(
                itemCount: visibleClubsCount,
                itemBuilder: (context, index) {
                  final club = allClubs[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(club['image']!),
                      radius: 30,
                    ),
                    title: Text(
                      club['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          followStatus[index] = !followStatus[index];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: followStatus[index]
                            ? const Color.fromARGB(255, 90, 10, 10)
                            : Colors.red,
                      ),
                      child: Text(
                        followStatus[index] ? 'Takip Ediliyor' : 'Takip Et',
                        style: const TextStyle(color: Colors.white),
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
                    // Kulüp sayısını tüm listeye genişlet
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
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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

// Grup Listesi İçeriği
class GroupListPageContent extends StatelessWidget {
  final Map<String, List<String>> groups = const {
    'Yerleşkeler': [
      'Yeşilırmak Yerleşkesi',
      'Milli Hakimiyet Yerleşkesi',
      'İpekköy Yerleşkesi'
    ],
    'Fakülteler': [
      'Mühendislik Fakültesi',
      'Eğitim Fakültesi',
      'Fen Edebiyat Fakültesi'
    ],
    'Bölümler': ['Bilgisayar Mühendisliği', 'Makine Mühendisliği']
  };

  const GroupListPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: groups.keys.map((category) {
        return ExpansionTile(
          leading: const Icon(Icons.group, color: Colors.redAccent),
          title: Text(
            category,
            style: const TextStyle(color: Colors.white),
          ),
          children: groups[category]!.map((group) {
            return ListTile(
              leading: const Icon(Icons.group_outlined, color: Colors.grey),
              title: Text(
                group,
                style: const TextStyle(color: Colors.white70),
              ),
              onTap: () {
                // Sohbet sayfasına yönlendirme
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(groupName: group),
                  ),
                );
              },
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

// Sohbet Ekranı
class ChatPage extends StatefulWidget {
  final String groupName;

  const ChatPage({super.key, required this.groupName});

  @override
  _ChatPageState createState() => _ChatPageState();
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
                        color: Colors.redAccent, // Mesaj balonunun rengi
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Mesajınızı yazın...',
                      hintStyle: TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Color.fromARGB(255, 215, 215, 215),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
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

void main() {
  runApp(const MyApp());
}
