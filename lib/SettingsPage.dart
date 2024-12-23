// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'ChatPage.dart';

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
    );
  }
}

class SettingsPage extends StatefulWidget {
  final bool darkTheme;
  final ValueChanged<bool> onThemeChanged;
  const SettingsPage(
      {super.key, required this.darkTheme, required this.onThemeChanged});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkTheme = true; // Karanlık mod durumu
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
                  // Karanlık mod açıldığında, temasını güncelle
                  // Bu, üst seviyedeki _MyAppState'de yapılabilir
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

void main() {
  runApp(MyApp());
}
