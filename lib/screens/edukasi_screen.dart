import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/data_models.dart';

class EdukasiScreen extends StatefulWidget {
  const EdukasiScreen({super.key});

  @override
  State<EdukasiScreen> createState() => _EdukasiScreenState();
}

class _EdukasiScreenState extends State<EdukasiScreen> {
  int _currentIndex = 2;
  String _selectedFilter = 'Semua Topik';

  final List<EducationItem> _educationItems = [
    EducationItem(
      title: 'Awas Penipuan Berkedok Kurir Paket Jelang Lebaran',
      category: 'Modus Terbaru',
      readTime: '5 min baca',
      description: 'Kenali ciri-ciri tautan berbahaya (APK) yang dikirimkan melalui aplikasi pesan berdalih...',
    ),
    EducationItem(
      title: 'Pentingnya Mengaktifkan Autentikasi Dua Faktor (2FA)',
      category: 'Tips Keamanan',
      readTime: '3 min baca',
      description: 'Pelajari cara mengaktifkan 2FA untuk melindungi akun Anda dari peretasan.',
    ),
    EducationItem(
      title: 'Pencurian Data Skala Besar Menargetkan Pengguna E-Wallet',
      category: 'Berita Siber',
      readTime: '7 min baca',
      description: 'Insiden keamanan siber skala besar mengkompromikan data jutaan pengguna.',
    ),
    EducationItem(
      title: 'Waspada Panggilan Telepon Mengatasnamakan CS Bank',
      category: 'Peringatan Dini',
      readTime: '2 min baca',
      description: 'Penipu berpura-pura menjadi customer service bank untuk mencuri data Anda.',
    ),
    EducationItem(
      title: '5 Kebiasaan Baik Saat Bertransaksi di Mesin ATM',
      category: 'Tips Keamanan',
      readTime: '4 min baca',
      description: 'Tips penting untuk melindungi kartu dan PIN Anda saat menggunakan ATM.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Pusat Edukasi & Modus',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              // Latest Modus Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFFF8A65)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'MODUS TERBARU',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '© 5 min baca',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Awas Penipuan Berkedok Kurir Paket Jelang Lebaran',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kenali ciri-ciri tautan berbahaya (APK) yang dikirimkan melalui aplikasi pesan berdalih...',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/alert_detail');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Pelajari Selengkapnya',
                        style: GoogleFonts.poppins(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Filter Buttons
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterButton('Semua Topik'),
                    _buildFilterButton('Modus Terbaru'),
                    _buildFilterButton('Tips'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Recommendations
              Text(
                'Rekomendasi Untuk Anda',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ..._educationItems.map((item) => _buildEducationCard(item)),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/cek');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/edukasi');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/profil');
              break;
          }
        },
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.greyLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: isSelected ? Colors.white : AppColors.greyDark,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEducationCard(EducationItem item) {
    Color categoryColor;
    switch (item.category) {
      case 'Modus Terbaru':
        categoryColor = AppColors.danger;
        break;
      case 'Berita Siber':
        categoryColor = AppColors.primary;
        break;
      case 'Peringatan Dini':
        categoryColor = AppColors.warning;
        break;
      default:
        categoryColor = AppColors.success;
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/edukasi_detail', arguments: item);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyMedium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item.category.toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: categoryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  item.readTime,
                  style: GoogleFonts.poppins(
                    color: AppColors.greyText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.description,
              style: GoogleFonts.poppins(
                color: AppColors.greyText,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}