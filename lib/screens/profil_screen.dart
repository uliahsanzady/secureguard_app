import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dashboard_screen.dart';
import 'cek_screen.dart';
import 'edukasi_screen.dart';
import 'login_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  int _currentIndex = 3;

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
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Budi Santoso',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Akun Terverifikasi',
                          style: GoogleFonts.poppins(
                            color: AppColors.success,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildMenuSection(
                title: 'AKUN & KEAMANAN',
                items: [
                  _buildMenuItem('Edit Profil', Icons.edit_outlined),
                  _buildMenuItem('Keamanan Akun', Icons.security_outlined, subtitle: 'Sangat Aman', isSecurity: true),
                  _buildMenuItem('Perangkat Tertaut', Icons.devices_outlined, subtitle: '2 aktif'),
                ],
              ),
              _buildMenuSection(
                title: 'AKTIVITAS SAYA',
                items: [
                  _buildMenuItem('Riwayat Laporan', Icons.report_outlined),
                  _buildMenuItem('Favorit Edukasi', Icons.favorite_outline),
                ],
              ),
              _buildMenuSection(
                title: 'PREFERENSI',
                items: [
                  _buildMenuItem('Notifikasi Peringatan', Icons.notifications_outlined),
                  _buildMenuItem('Bahasa', Icons.language_outlined, subtitle: 'ID >'),
                  _buildMenuItem('Mode Gelap', Icons.dark_mode_outlined),
                ],
              ),
              _buildMenuSection(
                title: 'LAINNYA',
                items: [
                  _buildMenuItem('Pusat Bantuan & FAQ', Icons.help_outline),
                  _buildMenuItem('Tentang SecureGuard', Icons.info_outline),
                  _buildMenuItem('Keluar', Icons.logout_outlined, isDanger: true),
                ],
              ),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CekScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EdukasiScreen()),
              );
              break;
            case 3:
              break;
          }
        },
      ),
    );
  }

  Widget _buildMenuSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.greyText,
              letterSpacing: 1,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.greyMedium),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              return Column(
                children: [
                  entry.value,
                  if (entry.key < items.length - 1)
                    const Divider(height: 0, color: AppColors.greyMedium),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon, {
    String? subtitle,
    bool isSecurity = false,
    bool isDanger = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDanger ? AppColors.danger : AppColors.primary,
        size: 22,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: isDanger ? AppColors.danger : AppColors.black,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (subtitle != null)
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: isSecurity ? AppColors.success : AppColors.greyText,
                fontSize: 13,
                fontWeight: isSecurity ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          if (!isSecurity && !isDanger)
            const Icon(
              Icons.chevron_right,
              color: AppColors.greyText,
            ),
          if (isSecurity)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                subtitle!,
                style: GoogleFonts.poppins(
                  color: AppColors.success,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        if (isDanger) {
          _showLogoutDialog(context);
        }
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari SecureGuard?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: const Text(
              'Keluar',
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}