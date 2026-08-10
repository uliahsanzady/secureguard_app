import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class LaporScreen extends StatefulWidget {
  const LaporScreen({super.key});

  @override
  State<LaporScreen> createState() => _LaporScreenState();
}

class _LaporScreenState extends State<LaporScreen> {
  int _currentIndex = 0;
  String? _selectedFraudType;
  String _story = '';
  int _storyLength = 0;

  final List<String> _fraudTypes = [
    'Penipuan Belanja Online',
    'Penipuan Investasi Bodong',
    'Penipuan Lowongan Kerja',
    'Penipuan Call Center',
    'Penipuan APK/Phishing',
    'Penipuan Pinjaman Online',
    'Lainnya',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lapor Cepat',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Bantu cegah korban lainnya. Laporan Anda langsung diteruskan ke tim Patroli Siber.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Step 1
              Text(
                '1. Jenis Penipuan',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedFraudType,
                    hint: Text(
                      'Pilih jenis kejadian...',
                      style: GoogleFonts.poppins(
                        color: AppColors.greyText,
                      ),
                    ),
                    isExpanded: true,
                    items: _fraudTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFraudType = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Step 2
              Text(
                '2. Detail Pelaku',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Nomor Telepon Pelaku (Opsional)',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Contoh: 0812 3456 7890',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Nomor Rekening / E-Wallet (Opsional)',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Contoh: 1234567890',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Step 3
              Text(
                '3. Ceritakan Kejadian',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  maxLines: 4,
                  onChanged: (value) {
                    setState(() {
                      _story = value;
                      _storyLength = value.length;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Jelaskan secara singkat bagaimana penipuan terjadi...',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    counterText: '$_storyLength/500',
                    counterStyle: GoogleFonts.poppins(
                      color: AppColors.greyText,
                      fontSize: 12,
                    ),
                  ),
                  maxLength: 500,
                ),
              ),
              const SizedBox(height: 24),
              // Step 4
              Text(
                '4. Bukti Pendukung',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Unggah screenshot chat, bukti transfer, atau link terkait.',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.greyMedium,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        color: AppColors.greyText,
                        size: 32,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tambah',
                        style: GoogleFonts.poppins(
                          color: AppColors.greyText,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Warning
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Jika Anda telah mentransfer dana, segera hubungi Call Center Bank Anda untuk pengajuan pemblokiran darurat sebelum mengirim laporan ini.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.greyDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Laporan berhasil dikirim ke Patroli Siber'),
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
                    'Kirim ke Patroli Siber →',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Data dienkripsi secara end-to-end',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.greyText,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}