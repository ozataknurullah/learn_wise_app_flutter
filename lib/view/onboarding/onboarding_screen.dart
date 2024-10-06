import 'package:flutter/material.dart';
import 'package:learn_wise/utils/app_color.dart';
import 'package:learn_wise/utils/app_styles.dart';
import 'package:learn_wise/view/auth/login_page.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _buildOnboardingPages() {
    return [
      _buildPage(
        image: 'assets/images/onboarding_1.png', // İlk onboarding görseli
        title: 'Notlarını Tara',
        description:
            'Notlarını hızlıca tarayıp dijital ortama aktarmanın kolay yolu.',
      ),
      _buildPage(
        image: 'assets/images/onboarding_2.png', // İkinci onboarding görseli
        title: 'Hazırla',
        description:
            'Yapay zeka destekli analizlerle çalışma kartları hazırla.',
      ),
      _buildPage(
        image: 'assets/images/onboarding_3.png', // Üçüncü onboarding görseli
        title: 'Çalış ve Öğren',
        description:
            'Özelleştirilmiş çalışma programları ile öğrenme sürecini hızlandır.',
      ),
    ];
  }

  Widget _buildPage(
      {required String image,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          const SizedBox(height: 20),
          Text(
            title,
            style: AppStyles.heading2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: AppStyles.bodyText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _buildOnboardingPages(),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Skip',
                style:
                    AppStyles.bodyText.copyWith(color: AppColors.accentColor),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                if (_currentPage == _buildOnboardingPages().length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Text(
                _currentPage == _buildOnboardingPages().length - 1
                    ? 'Start'
                    : 'Next',
                style:
                    AppStyles.bodyText.copyWith(color: AppColors.accentColor),
              ),
            ),
          ),
          Positioned(
            bottom: 60, // Sayfanın altına daha yakın olması için 60 verdik
            left: 0,
            right:
                0, // Ortalamak için left ve right değerlerini 0 olarak ayarlıyoruz
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _buildOnboardingPages().length,
                (index) => _buildDot(index: index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: _currentPage == index ? 12.0 : 8.0,
      height: _currentPage == index ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.primaryColor
            : AppColors.secondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
