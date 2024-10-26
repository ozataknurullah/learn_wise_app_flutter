import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learn_wise/viewmodels/profile_view_model.dart';

class ProfilePage extends StatelessWidget {
  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    print("Yerel depodan alınan Kullanıcı ID'si: $userId");
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null) {
          return Scaffold(
            body: Center(
              child: Text('Kullanıcı bilgileri alınamadı.'),
            ),
          );
        } else {
          return ChangeNotifierProvider(
            create: (_) => ProfileViewModel()..fetchUserData(),
            child: Consumer<ProfileViewModel>(
              builder: (context, profileViewModel, _) {
                if (profileViewModel.userData == null &&
                    profileViewModel.errorMessage == null) {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else if (profileViewModel.errorMessage != null) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                          'Bir hata oluştu: ${profileViewModel.errorMessage}'),
                    ),
                  );
                } else {
                  final userData = profileViewModel.userData!;
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Profil',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
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
                                    backgroundImage: AssetImage(
                                        'assets/images/profile_placeholder.png'),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${userData['first_name']} ${userData['last_name']}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                          initialChildSize: 0.65,
                          minChildSize: 0.5,
                          maxChildSize: 0.65,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Genel Bilgiler',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        leading: Icon(Icons.email),
                                        title: Text(userData['email']),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.phone),
                                        title: Text(userData['phone']),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.info),
                                        title: Text('Diğer Bilgiler...'),
                                      ),
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
              },
            ),
          );
        }
      },
    );
  }
}
