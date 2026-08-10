import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../models/data_models.dart';

class EdukasiDetailScreen extends StatelessWidget {
  const EdukasiDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EducationItem item = ModalRoute.of(context)?.settings.arguments as EducationItem? ?? 
      EducationItem(
        title: 'Pentingnya Mengaktifkan Autentikasi Dua Faktor (2FA)',
        category: 'Tips Keamanan',
        readTime: '3 min baca',
        description: 'Pelajari cara mengaktifkan 2FA untuk melindungi akun Anda dari peretasan.',
      );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.category,
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
            Text(
              item.title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item.category,
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  item.readTime,
                  style: GoogleFonts.poppins(
                    color: AppColors.greyText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // This would be the article content
            Text(
              'Apa itu 2FA?',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Autentikasi Dua Faktor (2FA) adalah metode keamanan yang memerlukan dua bentuk identifikasi untuk mengakses sebuah akun. Ini seperti memiliki kunci dan gembok terpisah untuk pintu rumah Anda.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Mengapa Ini Penting?',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Kata sandi saja tidak lagi cukup di era digital saat ini. Peretas sering kali membobol basis data atau menggunakan teknik phishing untuk mencuri kredensial.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(12),
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
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Gunakan aplikasi authenticator (seperti Google Authenticator atau Authy) daripada SMS untuk 2FA, karena SMS rentan terhadap penyadapan dan serangan SIM swapping.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.greyDark,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Langkah-langkah Aktivasi',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...['1. Buka pengaturan keamanan di akun Anda', 
              '2. Cari opsi "Keamanan" atau "Login & Keamanan"', 
              '3. Pilih "Autentikasi Dua Faktor" atau "2-Step Verification"', 
              '4. Pilih metode utama (Aplikasi Authenticator sangat direkomendasikan)', 
              '5. Ikuti petunjuk di layar untuk menautkan perangkat atau memindai kode QR', 
              '6. Simpan kode pemulihan (recovery codes) di tempat yang aman'].map((step) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        step.substring(0, 1),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      step.substring(2),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.greyDark,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 24),
            Text(
              'Artikel Terkait',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildRelatedArticle(
              context,
              'Mengenali Modus Phishing Melalui Email dan SMS',
              '4 min baca',
            ),
            _buildRelatedArticle(
              context,
              'Cara Membuat Kata Sandi yang Kuat dan Mudah Diingat',
              '2 min baca',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedArticle(BuildContext context, String title, String time) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EdukasiDetailScreen()),
        );
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