import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class TwofaDetailScreen extends StatelessWidget {
  const TwofaDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Autentikasi Dua Faktor (2FA)',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Icon(
                      Icons.security,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. Budi Santoso',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pakar Keamanan Siber',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Apa itu 2FA?',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Autentikasi Dua Faktor (2FA) adalah metode keamanan yang memerlukan dua bentuk identifikasi untuk mengakses sebuah akun. Ini seperti memiliki kunci dan gembok terpisah untuk pintu rumah Anda; meskipun seseorang mendapatkan kunci (password), mereka masih memerlukan gembok (kode dari ponsel) untuk masuk.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Mengapa Ini Penting?',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Kata sandi saja tidak lagi cukup di era digital saat ini. Peretas sering kali membobol basis data atau menggunakan teknik phishing untuk mencuri kredensial. Dengan 2FA, lapisan keamanan ekstra ditambahkan. Bahkan jika kata sandi Anda jatuh ke tangan yang salah, akun tetap terlindungi karena pelaku tidak memiliki perangkat fisik kedua Anda.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Pro Tip',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Gunakan aplikasi authenticator (seperti Google Authenticator atau Authy) daripada SMS untuk 2FA, karena SMS rentan terhadap penyadapan dan serangan SIM swapping.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.greyDark,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Langkah-langkah Aktivasi',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            _buildStep('1', 'Buka pengaturan keamanan di akun Anda (misal: Google, Facebook, atau Bank).'),
            _buildStep('2', 'Cari opsi "Keamanan" atau "Login & Keamanan".'),
            _buildStep('3', 'Pilih "Autentikasi Dua Faktor" atau "2-Step Verification".'),
            _buildStep('4', 'Pilih metode utama (Aplikasi Authenticator sangat direkomendasikan).'),
            _buildStep('5', 'Ikuti petunjuk di layar untuk menautkan perangkat atau memindai kode QR.'),
            _buildStep('6', 'Simpan kode pemulihan (recovery codes) di tempat yang aman.'),
            const SizedBox(height: 24),
            Text(
              'Artikel Terkait',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildRelatedArticle(
              'Mengenali Modus Phishing Melalui Email dan SMS',
              '4 min baca',
            ),
            _buildRelatedArticle(
              'Cara Membuat Kata Sandi yang Kuat dan Mudah Diingat',
              '2 min baca',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String number, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedArticle(String title, String time) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/edukasi_detail');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.greyMedium),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.article_outlined,
              color: AppColors.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    time,
                    style: GoogleFonts.poppins(
                      color: AppColors.greyText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.greyText,
            ),
          ],
        ),
      ),
    );
  }
}