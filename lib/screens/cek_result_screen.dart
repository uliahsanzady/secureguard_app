import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class CekResultScreen extends StatelessWidget {
  const CekResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String number = ModalRoute.of(context)?.settings.arguments as String? ?? '0812 3456 7890';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hasil Pengecekan',
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
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    number,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Nomor Terverifikasi Aman',
                      style: GoogleFonts.poppins(
                        color: AppColors.success,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tidak ditemukan riwayat penipuan terkait nomor ini.',
                    style: GoogleFonts.poppins(
                      color: AppColors.greyText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Analisis Reputasi',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyMedium),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Skor Keamanan',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.greyDark,
                        ),
                      ),
                      Text(
                        '98/100',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSourceResult(
                    'CEKREKENING.ID',
                    'Bersih, tidak ada laporan',
                    AppColors.success,
                  ),
                  _buildSourceResult(
                    'GETCONTACT API',
                    '150+ Tag positif',
                    AppColors.success,
                  ),
                  _buildSourceResult(
                    'GOOGLE SAFE BROWSING',
                    'Tidak ada ancaman siber',
                    AppColors.success,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Tag Komunitas',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'Kurir Paket',
                'Toko Sepatu Online',
                'CS BNI',
                'Driver Ojoi',
                '+146 lainnya',
              ].map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.greyDark,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Riwayat Pengecekan',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildHistoryItem('Hari ini, 10:42 WIB', 'Pengecekan selesai. Status diverifikasi aman.'),
            _buildHistoryItem('Hari ini, 10:41 WIB', 'Mengambil data dari 3 sumber terpercaya...'),
            _buildHistoryItem('Hari ini, 10:41 WIB', 'Pengecekan dimulai oleh Anda.'),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'BAGIKAN HASIL',
                      style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'SIMPAN KE KONTAK',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceResult(String source, String result, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              source,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          Text(
            result,
            style: GoogleFonts.poppins(
              color: AppColors.greyText,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String time, String description) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.greyMedium),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.history,
            size: 16,
            color: AppColors.greyText,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    color: AppColors.greyText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}