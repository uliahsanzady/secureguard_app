import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import 'twofa_detail_screen.dart';

class AlertDetailScreen extends StatelessWidget {
  const AlertDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Peringatan Keamanan',
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
                color: AppColors.danger.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.danger.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_rounded,
                    color: AppColors.danger,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tindakan Segera Dibutuhkan',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Jika Anda menggunakan aplikasi E-Wallet populer dalam 30 hari terakhir, segera ganti PIN dan periksa riwayat transaksi Anda.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TwofaDetailScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.danger,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Periksa Akun',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Peringatan telah disimpan'),
                          backgroundColor: AppColors.success,
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
                      'Save',
                      style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Kronologi Kejadian',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Baru-baru ini, sebuah insiden keamanan siber berskala besar telah mengkompromikan data jutaan pengguna dari salah satu platform E-Wallet terkemuka di Indonesia. Serangan yang terjadi pada akhir pekan lalu melibatkan peretasan basis data terpusat, yang mengakibatkan bocornya informasi sensitif.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Tim keamanan mendeteksi aktivitas anomali dari beberapa alamat IP di luar negeri yang berhasil melewati lapisan otentikasi awal. Penyelidikan awal menunjukkan adanya eksploitasi pada kerentanan zero-day di sistem API pihak ketiga yang terintegrasi.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Dampak bagi Pengguna',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Risiko utama dari kebocoran ini mencakup potensi penyalahgunaan informasi pribadi (PII). Data yang diyakini terdapat meliputi:',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('Nama lengkap dan nomor telepon'),
            _buildBulletPoint('Alamat email yang terdaftar riwayat transaksi (dienkripsi)'),
            const SizedBox(height: 24),
            Text(
              'Tindakan yang Harus Diambil',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Untuk memastikan keamanan dana dan data Anda, kami merekomendasikan langkah-langkah mitigasi berikut ini secepatnya:',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 8),
            _buildNumberedPoint(
              '1. Ganti PIN dan Kata Sandi',
              'Segera ubah kredensial login Anda. Hindari menggunakan PIN yang sama di platform lain.',
            ),
            _buildNumberedPoint(
              '2. Aktifkan Autentikasi Dua Faktor (2FA)',
              'Gunakan aplikasi authenticator untuk lapisan keamanan tambahan saat login.',
            ),
            _buildNumberedPoint(
              '3. Pantau Aktivitas Rekening',
              'Periksa secara berkala setiap mutasi dan laporkan transaksi yang tidak dikenali.',
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Center(
                child: Text(
                  'EDUKASI KEAMANAN SIBER SECUREGUARD',
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
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

  Widget _buildNumberedPoint(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
          const SizedBox(height: 2),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.greyDark,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}