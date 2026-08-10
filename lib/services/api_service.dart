import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL untuk CekRekening.id API
  static const String baseUrl = 'https://cekrekening.id/api';
  
  // API Key untuk Google Safe Browsing (DAFTARKAN GRATIS)
  // Kunjungi: https://developers.google.com/safe-browsing/v4/get-started
  static const String safeBrowsingKey = 'AIzaSyA6dltESwznQUOifOHTh0NzypmrIbnWBVc';

  /// Cek Rekening via CekRekening.id
  /// Parameter: accountNumber - nomor rekening yang ingin dicek
  static Future<Map<String, dynamic>> cekRekening(String accountNumber) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cekrekening'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'rekening': accountNumber}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'Gagal mengecek rekening. Status: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  /// Cek Tautan via Google Safe Browsing API
  /// Parameter: url - tautan yang ingin dicek
  static Future<Map<String, dynamic>> cekTautan(String url) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://safebrowsing.googleapis.com/v4/threatMatches:find?key=$safeBrowsingKey'
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'client': {
            'clientId': 'secureguard_app',
            'clientVersion': '1.0.0',
          },
          'threatInfo': {
            'threatTypes': [
              'MALWARE',
              'SOCIAL_ENGINEERING',
              'UNWANTED_SOFTWARE',
              'POTENTIALLY_HARMFUL_APPLICATION'
            ],
            'platformTypes': ['ANY_PLATFORM'],
            'threatEntryTypes': ['URL'],
            'threatEntries': [
              {'url': url}
            ],
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Jika response memiliki 'matches', berarti URL berbahaya
        if (data.containsKey('matches') && data['matches'].isNotEmpty) {
          return {
            'status': 'danger',
            'message': '⚠️ Tautan ini terdeteksi berbahaya!',
            'data': data,
          };
        } else {
          return {
            'status': 'safe',
            'message': '✅ Tautan aman',
            'data': data,
          };
        }
      } else {
        return {
          'status': 'error',
          'message': 'Gagal mengecek tautan. Status: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  /// Cek Nomor Telepon (Simulasi dengan data lokal + laporan komunitas)
  /// Karena GetContact tidak memiliki API publik, kita gunakan pendekatan alternatif
  static Future<Map<String, dynamic>> cekNomorTelepon(String phoneNumber) async {
    try {
      // TODO: Integrasikan dengan database laporan komunitas lokal
      // Untuk sekarang, kita gunakan simulasi dengan data dummy + validasi
      
      // Simulasi pengecekan ke database lokal
      final isSafe = await _checkLocalDatabase(phoneNumber);
      
      if (isSafe) {
        return {
          'status': 'safe',
          'message': '✅ Nomor aman',
          'score': 95,
          'reports': 0,
          'tags': ['Aman'],
        };
      } else {
        return {
          'status': 'warning',
          'message': '⚠️ Nomor ini pernah dilaporkan',
          'score': 45,
          'reports': 12,
          'tags': ['Penipuan', 'Spam'],
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  /// Simulasi database lokal
  static Future<bool> _checkLocalDatabase(String phoneNumber) async {
    // Daftar nomor yang dilaporkan (contoh)
    final List<String> blacklist = [
      '08123456789',
      '085799998888',
      '085799998889',
    ];
    
    // Cek apakah nomor ada di blacklist
    return !blacklist.contains(phoneNumber.replaceAll(RegExp(r'\s+'), ''));
  }

  /// Mendapatkan laporan populer (untuk halaman "Sedang Populer Dilaporkan")
  static Future<List<Map<String, dynamic>>> getPopularReports() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/popular-reports'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        // Fallback ke data dummy jika API gagal
        return [
          {
            'title': 'PENIPUAN LOKER',
            'number': '0857 9999 8888',
            'reports': 156,
            'color': '#F44336',
          },
          {
            'title': 'TOKO ONLINE FIKTIF',
            'number': '5544 3322 11',
            'reports': 89,
            'color': '#FFC107',
          },
        ];
      }
    } catch (e) {
      // Fallback ke data dummy
      return [
        {
          'title': 'PENIPUAN LOKER',
          'number': '0857 9999 8888',
          'reports': 156,
          'color': '#F44336',
        },
        {
          'title': 'TOKO ONLINE FIKTIF',
          'number': '5544 3322 11',
          'reports': 89,
          'color': '#FFC107',
        },
      ];
    }
  }
}