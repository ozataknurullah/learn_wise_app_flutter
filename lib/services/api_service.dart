import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:9000';
  //'https://80dd-194-27-232-12.ngrok-free.app'; //'http://192.168.56.1:9000'; //'http://10.0.2.2:9000'; // Backend URL'i

  Future<Map<String, dynamic>> signUp(String name, String lastName,
      String email, String password, String phone, String userType) async {
    final url = Uri.parse('$baseUrl/user/signup');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'first_name': name,
          'last_name': lastName,
          'email': email,
          'password': password,
          'phone': phone,
          'user_type': userType
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      // API katmanında hatayı fırlatıyoruz
      throw Exception('API çağrısı sırasında hata oluştu: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/user/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('API çağrısı sırasında hata oluştu: ${e.toString()}');
    }
  }

  // Kullanıcı bilgilerini almak için getUser fonksiyonu
  Future<Map<String, dynamic>> getUser(String userId) async {
    final url = Uri.parse('$baseUrl/user/$userId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Yanıt boş: Beklenmeyen veri formatı');
      }
    } else {
      throw Exception('API hatası: ${response.statusCode}');
    }
  }

  // Gelen yanıtları burada işleyebiliriz
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      if (response.body.trim().isNotEmpty) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Yanıt boş: Beklenmeyen veri formatı');
      }
    } else {
      throw Exception(
          'API hatası: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }
}
