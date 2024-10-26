import 'package:flutter/material.dart';
import 'package:learn_wise/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _userData;
  String? _errorMessage;

  Map<String, dynamic>? get userData => _userData;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId =
          prefs.getString('user_id'); // Kullanıcı ID'sini yerel depodan al
      print("fetchUserData - Yerel depodan alınan Kullanıcı ID'si: $userId");

      if (userId == null) {
        throw Exception('Kullanıcı ID bulunamadı');
      }

      final response = await _apiService.getUser(userId);
      _userData = response;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Kullanıcı bilgileri alınamadı: ${e.toString()}';
    }
    notifyListeners();
  }
}
