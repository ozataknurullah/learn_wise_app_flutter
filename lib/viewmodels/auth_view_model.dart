import 'package:flutter/material.dart';
import 'package:learn_wise/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  String? _errorMessage;
  String? _token;
  String? _userId;
  Map<String, dynamic>? _userData;

  String? get errorMessage => _errorMessage;
  String? get token => _token;
  String? get userId => _userId;
  Map<String, dynamic>? get userData => _userData;

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> signUp(String name, String lastName, String email,
      String password, String phone, String userType) async {
    try {
      clearErrorMessage(); // Hata mesajını sıfırlıyoruz.
      final response = await _apiService.signUp(
          name, lastName, email, password, phone, userType);

      if (response.containsKey('access_token') &&
          response.containsKey('user_id')) {
        _token = response['access_token'];
        final userIdMap = response['user_id'];

        if (userIdMap is Map && userIdMap.containsKey('InsertedID')) {
          _userId = userIdMap['InsertedID'];
        } else {
          throw Exception(
              'Beklenmeyen yanıt formatı: user_id eksik veya yanlış formatta.');
        }

        await _saveToken(_token!);
        await _saveUserId(_userId!);
        _errorMessage = null; // Hata mesajını sıfırlıyoruz.
      } else {
        _errorMessage =
            'Beklenmeyen veri formatı: Token veya kullanıcı bilgileri eksik.';
      }
    } catch (e) {
      // API katmanından gelen hatayı kullanıcının anlayabileceği şekilde yönetiyoruz.
      if (e.toString().contains('409')) {
        _errorMessage = 'E-posta veya telefon numarası zaten kayıtlı.';
      } else if (e.toString().contains('500')) {
        _errorMessage =
            'Sunucu hatası oluştu. Lütfen daha sonra tekrar deneyin.';
      } else {
        _errorMessage =
            'Kayıt işlemi sırasında bir hata oluştu. lütfen daha sonra tekrar deneyiniz';
        print(" ${e.toString()}");
      }
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      clearErrorMessage(); // Hata mesajını sıfırlıyoruz.
      final response = await _apiService.login(email, password);
      print("Login response: $response"); // Gelen yanıtı kontrol etmek için

      // Eğer yanıt başarılı ise ve statusCode 200 ise
      if (response['statusCode'] == 200) {
        print("Login başarılı.");
        // Yanıtta user bilgileri varsa ve içinde token bilgisi bulunuyorsa
        if (response.containsKey('user')) {
          final userMap = response['user'];
          if (userMap is Map &&
              userMap.containsKey('token') &&
              userMap.containsKey('ID')) {
            _token = userMap['token'];
            _userId = userMap['ID'];

            await _saveToken(_token!);
            await _saveUserId(_userId!);

            _errorMessage =
                null; // Başarılı olduğunda hata mesajını sıfırlıyoruz
          } else {
            _errorMessage =
                'Beklenmeyen veri formatı: Token veya kullanıcı bilgileri eksik.';
            debugPrint('API Yanıtı (Beklenmeyen Format): $response');
          }
        } else {
          _errorMessage =
              'Beklenmeyen veri formatı: Kullanıcı bilgileri eksik.';
          debugPrint('API Yanıtı (Beklenmeyen Format): $response');
        }
      } else {
        // Status kodu 200 değilse burada işleme alınıyor
        print("Status kodu 200 gelmedi. Hata mesajı işleniyor.");
        _errorMessage = response['error'] ?? 'Beklenmeyen bir hata oluştu.';
      }
    } catch (e) {
      // API katmanından gelen hatayı kullanıcının anlayabileceği şekilde yönetiyoruz.
      if (e.toString().contains('409')) {
        _errorMessage = 'E-posta veya şifre hatalı.';
      } else if (e.toString().contains('500')) {
        _errorMessage =
            'Sunucu hatası oluştu. Lütfen daha sonra tekrar deneyin.';
      } else {
        _errorMessage = _errorMessage = 'Giriş işlemi başarısız';

        debugPrint('Giriş Hatası: ${e.toString()}');
      }
    }
    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _saveUserId(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userId);
      print('User ID kaydedildi: $userId'); // Kontrol için log
    } catch (e) {
      print('User ID kaydedilirken hata: $e'); // Hata logu
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user_id');
    _token = null;
    _userId = null;
    _userData = null;
    notifyListeners();
  }
}
