import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class TentangScreen extends StatelessWidget {
  const TentangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tentang SecureGuard',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shield,
                size: 60,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'SecureGuard',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Digital Fraud Prevention',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Version 1.0.0',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.greyText,
              ),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            _buildInfoItem(
              'Tentang Aplikasi',
              'SecureGuard adalah aplikasi pencegahan penipuan digital yang membantu Anda memeriksa kredibilitas nomor, rekening, dan tautan sebelum bertransaksi.',
            ),
            const SizedBox(height: 16),
            _buildInfoItem(
              'Fitur Utama',
              '• Cek Kredibilitas (Nomor, Rekening, Tautan)\n• Scanner Pesan dengan deteksi penipuan\n• Pusat Edukasi & Modus Terbaru\n• Lapor Penipuan Cepat\n• Notifikasi Peringatan Keamanan',
            ),
            const SizedBox(height: 16),
            _buildInfoItem(
              'Sumber Data',
              '• CekRekening.id (Kominfo)\n• Google Safe Browsing\n• Database Laporan Komunitas',
            ),
            const SizedBox(height: 16),
            _buildInfoItem(
              'Kontak',
              'Email: support@secureguard.id\nTelepon: 021-1234-5678',
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.lock_outline,
                    color: AppColors.success,
                    size: 24,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '🔒 Enkripsi End-to-End Aktif',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.greyDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Data Anda aman dan terlindungi',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.greyText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '© 2024 SecureGuard. All rights reserved.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.greyDark,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}