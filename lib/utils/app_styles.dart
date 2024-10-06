import 'package:flutter/material.dart';
import 'package:learn_wise/utils/app_color.dart';
import 'app_text_styles.dart';

class AppStyles {
  // Renkler
  static const Color primaryColor = AppColors.primaryColor;
  static const Color secondaryColor = AppColors.secondaryColor;
  static const Color accentColor = Color.fromARGB(255, 186, 206, 188);
  static const Color backgroundColor = AppColors.backgroundColor;
  static const Color textColor = AppColors.textColor;
  static const Color errorColor = AppColors.errorColor;

  // Yazı Stilleri
  static const TextStyle heading1 = AppTextStyles.heading1; // Başlık 1
  static const TextStyle heading2 = AppTextStyles.heading2; // Başlık 2
  static const TextStyle bodyText = AppTextStyles.bodyText; // Gövde metni
  static const TextStyle smallText = AppTextStyles.smallText; // Küçük metin
  static const TextStyle errorText = AppTextStyles.errorText; // Hata mesajları

  // Buton Stilleri
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    textStyle:
        bodyText.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    textStyle:
        bodyText.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );

  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: accentColor,
    textStyle: smallText.copyWith(
      color: accentColor,
      fontWeight: FontWeight.w600,
    ),
  );

  // TextField Stilleri
  static InputDecoration textFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: bodyText.copyWith(color: textColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: textColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor, width: 2.0),
      ),
    );
  }

  // Genel Yükleme Göstergesi Stili (Loading Indicator)
  static Widget loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
      ),
    );
  }
}
