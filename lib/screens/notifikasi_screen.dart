import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class NotifikasiScreen extends StatefulWidget {
  const NotifikasiScreen({super.key});

  @override
  State<NotifikasiScreen> createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiScreen> {
  bool _allNotifications = true;
  bool _securityAlerts = true;
  bool _fraudUpdates = true;
  bool _promoTips = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi Peringatan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengaturan Notifikasi',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // All Notifications
            _buildNotificationToggle(
              title: 'Semua Notifikasi',
              subtitle: 'Aktifkan atau nonaktifkan semua notifikasi',
              value: _allNotifications,
              onChanged: (value) {
                setState(() {
                  _allNotifications = value;
                  _securityAlerts = value;
                  _fraudUpdates = value;
                  _promoTips = value;
                });
              },
            ),
            const SizedBox(height: 8),

            // Security Alerts
            _buildNotificationToggle(
              title: 'Peringatan Keamanan',
              subtitle: 'Notifikasi tentang aktivitas mencurigakan',
              value: _securityAlerts,
              enabled: _allNotifications,
              onChanged: (value) {
                setState(() {
                  _securityAlerts = value;
                });
              },
            ),
            const SizedBox(height: 8),

            // Fraud Updates
            _buildNotificationToggle(
              title: 'Update Modus Penipuan',
              subtitle: 'Informasi tentang modus penipuan terbaru',
              value: _fraudUpdates,
              enabled: _allNotifications,
              onChanged: (value) {
                setState(() {
                  _fraudUpdates = value;
                });
              },
            ),
            const SizedBox(height: 8),

            // Promo Tips
            _buildNotificationToggle(
              title: 'Tips & Promo',
              subtitle: 'Tips keamanan dan promo menarik',
              value: _promoTips,
              enabled: _allNotifications,
              onChanged: (value) {
                setState(() {
                  _promoTips = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Pengaturan notifikasi disimpan'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Simpan Pengaturan',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationToggle({
    required String title,
    required String subtitle,
    required bool value,
    bool enabled = true,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyMedium),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.greyText,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}