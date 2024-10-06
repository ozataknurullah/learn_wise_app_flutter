import 'package:flutter/material.dart';
import 'package:learn_wise/utils/app_color.dart';

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16.0,
    color: AppColors.textColor,
  );

  static const TextStyle smallText = TextStyle(
    fontSize: 12.0,
    color: AppColors.textColor,
  );

  static const TextStyle errorText = TextStyle(
    fontSize: 14.0,
    color: AppColors.errorColor,
    fontWeight: FontWeight.bold,
  );
}
