// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'AddGroupPage.dart';
import 'ResetPasswordPage.dart';

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
    SettingsPage(), // Ayarlar listesi ayrı bir widget
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
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
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

//Profil sayfası
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.red,
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
      backgroundColor: const Color(0xFF1E1E2C),
    );
  }
}

//Ayarlar listesi içeriği
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkTheme = false;
  String _language = 'Türkçe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Dil Seçimi
            ListTile(
              title: const Text('Dil Seçimi'),
              subtitle: Text(_language),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Dil seçimi yapılacak
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Dil Seçimi'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          ListTile(
                            title: Text('Türkçe'),
                          ),
                          ListTile(
                            title: Text('English'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const Divider(),

            // Bildirimler
            SwitchListTile(
              title: const Text('Bildirimler'),
              subtitle: const Text('Bildirimleri aç/kapat'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            const Divider(),

            // Tema Seçimi
            SwitchListTile(
              title: const Text('Karanlık Mod'),
              subtitle: const Text('Karanlık modu aç/kapat'),
              value: _darkTheme,
              onChanged: (bool value) {
                setState(() {
                  _darkTheme = value;
                });
              },
            ),
            const Divider(),

            // Yedekleme ve Senkronizasyon
            ListTile(
              title: const Text('Veri Yedekleme ve Senkronizasyon'),
              trailing: const Icon(Icons.cloud_sync),
              onTap: () {
                // Yedekleme işlemi yapılacak
              },
            ),
            const Divider(),

            // Hesap Yönetimi
            ListTile(
              title: const Text('Hesap Yönetimi'),
              trailing: const Icon(Icons.person),
              onTap: () {
                // Hesap yönetimi (Çıkış yap, hesap sil) sayfasına yönlendirebilirsiniz
              },
            ),
            const Divider(),

            // Sohbet Ayarları
            ListTile(
              title: const Text('Sohbet Ayarları'),
              trailing: const Icon(Icons.chat_bubble),
              onTap: () {
                // Sohbet arka planı değiştirilebilir
              },
            ),
            const Divider(),

            // Yardım ve Destek
            ListTile(
              title: const Text('Yardım ve Destek'),
              trailing: const Icon(Icons.help),
              onTap: () {
                // Yardım ve destek sayfasına yönlendirilebilir
              },
            ),
            const Divider(),

            // Uygulama Sürümü
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Uygulama Sürümü: 1.0.0',
                style: TextStyle(
                  color: Colors.grey[600],
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

void main() {
  runApp(const MyApp());
}
