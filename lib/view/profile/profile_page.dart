import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 700,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profil',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        IconButton(
                          onPressed: () {
                            // Ayarlar için bir aksiyon eklenebilir
                          },
                          icon: Icon(Icons.settings),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/profile_placeholder.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'John Doe', // Statik kullanıcı adı
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Buton aksiyonu
                      },
                      child: const Text('Button'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.65, // Üst bölümün hemen altında başlatıyoruz
            minChildSize:
                0.5, // Minimum boyut (yani üst bölümün altından başlat)
            maxChildSize: 0.65, // Kullanıcı kaydırarak açabilir
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Genel Bilgiler',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text('johndoe@example.com'), // Statik email
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(
                              '+90 555 123 4567'), // Statik telefon numarası
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text(
                              'Diğer Bilgiler...'), // Statik diğer bilgiler
                        ),
                        // Diğer içerikler burada yer alabilir
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
