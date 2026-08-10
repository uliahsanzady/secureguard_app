import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final DatabaseHelper _db = DatabaseHelper();

  // Register user
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      // Cek apakah email sudah terdaftar
      var existingUser = await _db.getUserByEmail(email);
      if (existingUser != null) {
        return {
          'success': false,
          'message': 'Email sudah terdaftar. Silakan gunakan email lain.',
        };
      }

      // Insert user ke database
      int userId = await _db.insertUser({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'created_at': DateTime.now().toIso8601String(),
      });

      // Simpan session login
      await _saveUserSession(userId, name, email);

      return {
        'success': true,
        'message': 'Pendaftaran berhasil!',
        'userId': userId,
        'user': {
          'id': userId,
          'name': name,
          'email': email,
          'phone': phone,
        },
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  // Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      var user = await _db.getUserByEmailAndPassword(email, password);
      if (user == null) {
        return {
          'success': false,
          'message': 'Email atau kata sandi salah.',
        };
      }

      // Simpan session login
      await _saveUserSession(user['id'], user['name'], user['email']);

      return {
        'success': true,
        'message': 'Login berhasil!',
        'user': user,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  // Save user session to SharedPreferences
  Future<void> _saveUserSession(int userId, String name, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setInt('user_id', userId);
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  // Get current user data
  Future<Map<String, dynamic>?> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    if (!isLoggedIn) return null;

    int userId = prefs.getInt('user_id') ?? 0;
    String name = prefs.getString('user_name') ?? '';
    String email = prefs.getString('user_email') ?? '';

    // Ambil data lengkap dari database
    var user = await _db.getUserByEmail(email);
    return user;
  }

  // Get current user ID
  Future<int> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? 0;
  }

  // Get current user name
  Future<String> getCurrentUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name') ?? 'User';
  }

  // Get current user email
  Future<String> getCurrentUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email') ?? '';
  }

  // Logout
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
  }
}