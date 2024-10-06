import 'package:flutter/material.dart';
import 'package:learn_wise/utils/app_text_styles.dart';
import 'dart:async';

import 'package:learn_wise/view/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      // 3 saniye sonra onboarding ekranına geçiş yap
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Gönderdiğiniz logo görseli burada kullanılmalı
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'notlarını tara, hazırla ve çalış 📚',
              style: AppTextStyles.bodyText.copyWith(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '@nurullahozatak',
              style: AppTextStyles.smallText.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
