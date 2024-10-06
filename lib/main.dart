import 'package:flutter/material.dart';
import 'package:learn_wise/utils/app_styles.dart';
import 'package:learn_wise/view/main_navigation_page.dart';
import 'package:learn_wise/viewmodels/ai_asistant_model.dart';
import 'package:learn_wise/viewmodels/camera_view_model.dart';
import 'package:learn_wise/viewmodels/main_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainViewModel()),
        ChangeNotifierProvider(create: (_) => AIAssistantViewModel()),
        ChangeNotifierProvider(create: (_) => CameraViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LearnWise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppStyles.backgroundColor,
      ),
      home:
          MainNavigationPage(), // Uygulamanın açılışında splash ekranı gösterecek
    );
  }
}
