import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import 'edukasi_detail_screen.dart';

class FavoritEdukasiScreen extends StatelessWidget {
  const FavoritEdukasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> favorites = [
      {
        'title': 'Pentingnya Mengaktifkan Autentikasi Dua Faktor (2FA)',
        'category': 'Tips Keamanan',
        'readTime': '3 min baca',
      },
      {
        'title': '5 Kebiasaan Baik Saat Bertransaksi di Mesin ATM',
        'category': 'Tips Keamanan',
        'readTime': '4 min baca',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorit Edukasi',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: AppColors.greyText,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada favorit',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Simpan artikel edukasi favorit Anda di sini',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.greyText,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EdukasiDetailScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.greyMedium),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: AppColors.danger,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      item['category'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    item['readTime'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.greyText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Dihapus dari favorit'),
                                backgroundColor: AppColors.warning,
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.greyText,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}