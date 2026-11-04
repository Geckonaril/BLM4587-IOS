import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const baseUrl = 'http://127.0.0.1:5080/api/auth';

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return _authenticate('/register', {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return _authenticate('/login', {'email': email, 'password': password});
  }

  Future<Map<String, dynamic>> _authenticate(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl$endpoint'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 15));

    final decoded = jsonDecode(response.body);
    final data = Map<String, dynamic>.from(decoded);

    if (response.statusCode != 200) {
      throw Exception(
        data['message']?.toString() ?? 'İşlem gerçekleştirilemedi.',
      );
    }

    final token = data['token'] as String;

    await storage.write(key: 'access_token', value: token);

    return data;
  }

  Future<bool> hasValidSession() async {
    final token = await storage.read(key: 'access_token');

    if (token == null) return false;

    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/me'),
            headers: {'Authorization': 'Bearer $token'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 401) {
        await logout();
        return false;
      }

      if (response.statusCode != 200) {
        throw Exception('Oturum doğrulanamadı.');
      }

      return true;
    } catch (_) {
      // Bağlantı hatasında token silinmez.
      // Kullanıcı daha sonra yeniden deneyebilir.
      rethrow;
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
  }
}
