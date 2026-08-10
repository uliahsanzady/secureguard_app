import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class CekResultScreen extends StatelessWidget {
  const CekResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    // Default values jika tidak ada data
    final String query = args?['query'] ?? '0812 3456 7890';
    final String type = args?['type'] ?? 'Nomor';
    final Map<String, dynamic> result = args?['result'] ?? {
      'status': 'safe',
      'message': '✅ Tidak ditemukan riwayat penipuan',
      'score': 98,
    };

    final bool isSafe = result['status'] == 'safe';
    final String statusMessage = result['message'] ?? 'Tidak ditemukan riwayat penipuan terkait data ini.';
    final int score = result['score'] ?? 98;

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
                color: isSafe ? AppColors.success.withOpacity(0.1) : AppColors.danger.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSafe ? AppColors.success : AppColors.danger,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isSafe ? Icons.check_circle : Icons.warning_rounded,
                        color: isSafe ? AppColors.success : AppColors.danger,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          query,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSafe ? AppColors.success.withOpacity(0.1) : AppColors.danger.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isSafe ? '✅ Terverifikasi Aman' : '⚠️ Perlu Diwaspadai',
                      style: GoogleFonts.poppins(
                        color: isSafe ? AppColors.success : AppColors.danger,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    statusMessage,
                    style: GoogleFonts.poppins(
                      color: AppColors.greyDark,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Jenis: $type',
                    style: GoogleFonts.poppins(
                      color: AppColors.greyText,
                      fontSize: 12,
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
                        '$score/100',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: score >= 70 ? AppColors.success : AppColors.danger,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: score / 100,
                    backgroundColor: AppColors.greyLight,
                    color: score >= 70 ? AppColors.success : AppColors.danger,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 16),
                  _buildSourceResult(
                    'CEKREKENING.ID',
                    result['cekrekening'] ?? 'Bersih, tidak ada laporan',
                    AppColors.success,
                  ),
                  _buildSourceResult(
                    'GOOGLE SAFE BROWSING',
                    result['safebrowsing'] ?? 'Tidak ada ancaman',
                    AppColors.success,
                  ),
                  _buildSourceResult(
                    'LAPORAN KOMUNITAS',
                    '${result['reports'] ?? 0} laporan',
                    score >= 70 ? AppColors.success : AppColors.warning,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (result['tags'] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    children: (result['tags'] as List<dynamic>).map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.greyLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tag.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.greyDark,
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            Text(
              'Riwayat Pengecekan',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildHistoryItem('Hari ini, ${DateTime.now().toString().substring(11, 16)} WIB', 'Pengecekan selesai. Status diverifikasi ${isSafe ? 'aman' : 'perlu diwaspadai'}.'),
            _buildHistoryItem('Hari ini, ${DateTime.now().toString().substring(11, 16)} WIB', 'Mengambil data dari 3 sumber terpercaya...'),
            _buildHistoryItem('Hari ini, ${DateTime.now().toString().substring(11, 16)} WIB', 'Pengecekan dimulai oleh Anda.'),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hasil berhasil dibagikan'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    },
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
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data berhasil disimpan'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'SIMPAN',
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
      padding: const EdgeInsets.symmetric(vertical: 6),
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