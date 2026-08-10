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
      home: const LoginScreen(),
    );
  }
}