import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/cek_screen.dart';
import 'screens/edukasi_screen.dart';
import 'screens/profil_screen.dart';
import 'screens/lapor_screen.dart';
import 'screens/cek_result_screen.dart';
import 'screens/edukasi_detail_screen.dart';
import 'screens/alert_detail_screen.dart';
import 'screens/twofa_detail_screen.dart';

void main() {
  runApp(const SecureGuardApp());
}

class SecureGuardApp extends StatelessWidget {
  const SecureGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureGuard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1A237E),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1A237E),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/dashboard':
            return MaterialPageRoute(builder: (_) => const DashboardScreen());
          case '/cek':
            return MaterialPageRoute(builder: (_) => const CekScreen());
          case '/edukasi':
            return MaterialPageRoute(builder: (_) => const EdukasiScreen());
          case '/profil':
            return MaterialPageRoute(builder: (_) => const ProfilScreen());
          case '/lapor':
            return MaterialPageRoute(builder: (_) => const LaporScreen());
          case '/cek_result':
            return MaterialPageRoute(builder: (_) => const CekResultScreen());
          case '/edukasi_detail':
            return MaterialPageRoute(builder: (_) => const EdukasiDetailScreen());
          case '/alert_detail':
            return MaterialPageRoute(builder: (_) => const AlertDetailScreen());
          case '/2fa_detail':
            return MaterialPageRoute(builder: (_) => const TwofaDetailScreen());
          default:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      },
    );
  }
}