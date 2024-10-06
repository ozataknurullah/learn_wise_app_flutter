import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:learn_wise/view/ai_asistant/ai_asistant_page.dart';
import 'package:learn_wise/view/camera/camera_page.dart';
import 'package:learn_wise/view/home/home_page.dart';
import 'package:learn_wise/view/profile/profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics:
            NeverScrollableScrollPhysics(), // Kullanıcı kaydırarak sayfa değiştiremez
        children: [
          HomePage(),
          AIAssistantPage(),
          CameraPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 128, 128, 128).withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 5), // gölgenin konumu
              ),
            ],
          ),
          child: GNav(
            curve: Curves.easeIn,
            gap: 8,
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            backgroundColor:
                Colors.transparent, // Container'ın rengi kullanılacak
            color: const Color.fromARGB(255, 139, 95, 95),
            activeColor: Colors.orange,
            tabBackgroundColor: Colors.orange.withOpacity(0.1),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Ana Sayfa',
              ),
              GButton(
                icon: Icons.assistant,
                text: 'AI Asistan',
              ),
              GButton(
                icon: Icons.camera_alt,
                text: 'Kamera',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
