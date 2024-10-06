import 'package:flutter/material.dart';

class AIAssistantViewModel extends ChangeNotifier {
  String? summaryText;

  // Bu metot, özet veriyi günceller.
  void updateSummary(String newSummary) {
    summaryText = newSummary;
    notifyListeners();
  }

  // Örnek bir AI işlemi yaparak sahte veri döndürüyoruz (gerçek AI entegrasyonu burada yapılabilir).
  Future<void> getSummaryData() async {
    // Simülasyon için kısa bir gecikme ekliyoruz.
    await Future.delayed(Duration(seconds: 2));
    summaryText =
        "Bu, özetlenen metindir. Burada yapay zeka tarafından özetleme yapılabilir.";
    notifyListeners();
  }
}
