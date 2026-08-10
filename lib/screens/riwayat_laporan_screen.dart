import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class RiwayatLaporanScreen extends StatelessWidget {
  const RiwayatLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reports = [
      {
        'title': 'Penipuan Call Center',
        'date': '15 Juli 2026',
        'status': 'Diproses',
        'statusColor': AppColors.warning,
        'description': 'Penipu mengatasnamakan CS Bank BCA',
      },
      {
        'title': 'Modus APK Kurir',
        'date': '12 Juli 2026',
        'status': 'Selesai',
        'statusColor': AppColors.success,
        'description': 'APK berkedok resi pengiriman JNE',
      },
      {
        'title': 'Toko Online Fiktif',
        'date': '8 Juli 2026',
        'status': 'Ditolak',
        'statusColor': AppColors.danger,
        'description': 'Toko @shopee_fashion palsu',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Laporan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Riwayat laporan telah dibersihkan'),
                  backgroundColor: AppColors.warning,
                ),
              );
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: reports.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.report_off_outlined,
                    size: 64,
                    color: AppColors.greyText,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada laporan',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Laporan penipuan Anda akan muncul di sini',
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              report['title'],
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: report['statusColor'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              report['status'],
                              style: GoogleFonts.poppins(
                                color: report['statusColor'],
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        report['description'],
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.greyText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        report['date'],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}