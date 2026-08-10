import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class BantuanScreen extends StatelessWidget {
  const BantuanScreen({super.key});

  final List<Map<String, dynamic>> faqs = const [
    {
      'question': 'Bagaimana cara mengecek rekening?',
      'answer': 'Buka menu "Cek" di bottom navigation, pilih jenis "Rekening", lalu masukkan nomor rekening yang ingin dicek.',
    },
    {
      'question': 'Apa itu modus APK?',
      'answer': 'Modus APK adalah penipuan dengan mengirimkan file APK berkedok aplikasi resmi untuk mencuri data pengguna.',
    },
    {
      'question': 'Bagaimana cara melaporkan penipuan?',
      'answer': 'Klik tombol "Lapor Penipuan" di halaman Dashboard, isi formulir lengkap, lalu kirim laporan.',
    },
    {
      'question': 'Apa itu autentikasi 2FA?',
      'answer': '2FA adalah lapisan keamanan tambahan yang memerlukan verifikasi dua langkah saat login.',
    },
    {
      'question': 'Apakah data saya aman di SecureGuard?',
      'answer': 'Ya, semua data dienkripsi end-to-end dan tidak dibagikan ke pihak ketiga tanpa izin.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pusat Bantuan & FAQ',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari pertanyaan...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  prefixIcon: const Icon(Icons.search, color: AppColors.greyText),
                ),
                onChanged: (value) {
                  // Implement search functionality
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                final faq = faqs[index];
                return _buildFaqItem(faq, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(Map<String, dynamic> faq, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyMedium),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            faq['question'],
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                faq['answer'],
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.greyDark,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}