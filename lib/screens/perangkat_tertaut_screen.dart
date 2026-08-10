import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class PerangkatTertautScreen extends StatelessWidget {
  const PerangkatTertautScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> devices = [
      {
        'name': 'iPhone 14 Pro',
        'model': 'Apple iPhone 14 Pro',
        'os': 'iOS 17.4',
        'lastActive': 'Sekarang',
        'isCurrent': true,
        'icon': Icons.phone_iphone,
      },
      {
        'name': 'MacBook Pro',
        'model': 'MacBook Pro 16" 2023',
        'os': 'macOS Sonoma 14.3',
        'lastActive': '2 jam yang lalu',
        'isCurrent': false,
        'icon': Icons.laptop_mac,
      },
      {
        'name': 'Chrome - Windows',
        'model': 'Windows 11 PC',
        'os': 'Chrome 127.0.0',
        'lastActive': '3 hari yang lalu',
        'isCurrent': false,
        'icon': Icons.computer,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perangkat Tertaut',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: device['isCurrent'] == true
                  ? AppColors.primary.withOpacity(0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: device['isCurrent'] == true
                    ? AppColors.primary
                    : AppColors.greyMedium,
                width: device['isCurrent'] == true ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    device['icon'],
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            device['name'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          if (device['isCurrent'] == true) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Aktif',
                                style: GoogleFonts.poppins(
                                  color: AppColors.success,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        device['model'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.greyText,
                        ),
                      ),
                      Text(
                        '${device['os']} • Terakhir: ${device['lastActive']}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
                if (device['isCurrent'] == false)
                  IconButton(
                    onPressed: () {
                      _showRemoveDeviceDialog(context, device['name']);
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: AppColors.danger,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showRemoveDeviceDialog(BuildContext context, String deviceName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Perangkat'),
        content: Text(
          'Apakah Anda yakin ingin menghapus perangkat "$deviceName"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('✅ Perangkat $deviceName berhasil dihapus'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.danger,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}