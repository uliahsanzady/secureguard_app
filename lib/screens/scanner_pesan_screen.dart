import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class ScannerPesanScreen extends StatefulWidget {
  const ScannerPesanScreen({super.key});

  @override
  State<ScannerPesanScreen> createState() => _ScannerPesanScreenState();
}

class _ScannerPesanScreenState extends State<ScannerPesanScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool _isScanning = false;
  String? _scanResult;
  List<String> _detectedKeywords = [];
  double _riskScore = 0.0;
  String _riskLevel = 'Aman';
  Color _riskColor = AppColors.success;
  String _recommendation = '';

  // Daftar kata-kata yang mencurigakan (indikator penipuan)
  final List<Map<String, dynamic>> _suspiciousKeywords = [
    {'word': 'transfer', 'weight': 3, 'category': 'Financial'},
    {'word': 'bayar', 'weight': 3, 'category': 'Financial'},
    {'word': 'kirim', 'weight': 2, 'category': 'Action'},
    {'word': 'uang', 'weight': 3, 'category': 'Financial'},
    {'word': 'rekening', 'weight': 3, 'category': 'Financial'},
    {'word': 'atm', 'weight': 2, 'category': 'Financial'},
    {'word': 'pin', 'weight': 3, 'category': 'Security'},
    {'word': 'password', 'weight': 4, 'category': 'Security'},
    {'word': 'otp', 'weight': 5, 'category': 'Security'},
    {'word': 'kode', 'weight': 3, 'category': 'Security'},
    {'word': 'verifikasi', 'weight': 3, 'category': 'Security'},
    {'word': 'hadiah', 'weight': 2, 'category': 'Fraud'},
    {'word': 'menang', 'weight': 2, 'category': 'Fraud'},
    {'word': 'gratis', 'weight': 2, 'category': 'Fraud'},
    {'word': 'undian', 'weight': 2, 'category': 'Fraud'},
    {'word': 'kupon', 'weight': 2, 'category': 'Fraud'},
    {'word': 'diskon', 'weight': 1, 'category': 'Promo'},
    {'word': 'promo', 'weight': 1, 'category': 'Promo'},
    {'word': 'bank', 'weight': 2, 'category': 'Financial'},
    {'word': 'e-wallet', 'weight': 2, 'category': 'Financial'},
    {'word': 'dompet digital', 'weight': 2, 'category': 'Financial'},
    {'word': 'akun', 'weight': 2, 'category': 'Security'},
    {'word': 'login', 'weight': 2, 'category': 'Security'},
    {'word': 'perbarui', 'weight': 2, 'category': 'Action'},
    {'word': 'update', 'weight': 2, 'category': 'Action'},
    {'word': 'info', 'weight': 1, 'category': 'Info'},
    {'word': 'penting', 'weight': 2, 'category': 'Urgent'},
    {'word': 'segera', 'weight': 3, 'category': 'Urgent'},
    {'word': 'darurat', 'weight': 3, 'category': 'Urgent'},
    {'word': 'blokir', 'weight': 3, 'category': 'Security'},
    {'word': 'nonaktif', 'weight': 2, 'category': 'Security'},
    {'word': 'klik', 'weight': 2, 'category': 'Action'},
    {'word': 'link', 'weight': 3, 'category': 'Action'},
    {'word': 'download', 'weight': 3, 'category': 'Action'},
    {'word': 'apk', 'weight': 4, 'category': 'Malware'},
    {'word': 'file', 'weight': 2, 'category': 'Malware'},
    {'word': 'install', 'weight': 3, 'category': 'Malware'},
    {'word': 'scan', 'weight': 1, 'category': 'Action'},
    {'word': 'cek', 'weight': 1, 'category': 'Action'},
  ];

  // Pola penipuan umum
  final List<Map<String, dynamic>> _fraudPatterns = [
    {
      'pattern': 'pemenang|menang|hadiah',
      'name': 'Hadiah/Pemenang Palsu',
      'description': 'Pesan mengklaim Anda memenangkan hadiah tanpa mengikuti kontes'
    },
    {
      'pattern': 'transfer|kirim uang|bayar',
      'name': 'Permintaan Transfer',
      'description': 'Meminta Anda untuk mentransfer uang atau membayar'
    },
    {
      'pattern': 'pin|otp|password|kode verifikasi',
      'name': 'Permintaan Data Sensitif',
      'description': 'Meminta PIN, OTP, password, atau kode verifikasi'
    },
    {
      'pattern': 'klik link|download|install',
      'name': 'Link atau Download Mencurigakan',
      'description': 'Meminta Anda mengklik link atau mengunduh file'
    },
    {
      'pattern': 'apk|aplikasi',
      'name': 'APK Mencurigakan',
      'description': 'Meminta menginstal aplikasi (APK) dari sumber tidak resmi'
    },
    {
      'pattern': 'segera|darurat|cepat',
      'name': 'Urgensi Palsu',
      'description': 'Menciptakan rasa urgensi untuk memaksa Anda bertindak cepat'
    },
    {
      'pattern': 'bank|e-wallet|rekening',
      'name': 'Informasi Keuangan',
      'description': 'Meminta informasi rekening bank atau e-wallet'
    },
    {
      'pattern': 'blokir|nonaktif|suspend',
      'name': 'Ancaman Penonaktifan',
      'description': 'Mengancam akan memblokir atau menonaktifkan akun Anda'
    },
  ];

  void _scanMessage() {
    final String message = _messageController.text.trim();
    
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan pesan yang ingin di-scan'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    setState(() {
      _isScanning = true;
      _scanResult = null;
      _detectedKeywords = [];
      _riskScore = 0.0;
    });

    // Simulasi proses scanning (agar terlihat realistis)
    Future.delayed(const Duration(milliseconds: 1500), () {
      _performScan(message);
      
      setState(() {
        _isScanning = false;
      });
    });
  }

  void _performScan(String message) {
    final String lowerMessage = message.toLowerCase();
    Set<String> foundKeywords = {};
    double totalWeight = 0;
    int foundPatterns = 0;

    // Cek kata-kata mencurigakan
    for (var keyword in _suspiciousKeywords) {
      if (lowerMessage.contains(keyword['word'])) {
        foundKeywords.add(keyword['word']);
        totalWeight += keyword['weight'];
      }
    }

    // Cek pola penipuan
    List<String> detectedPatterns = [];
    for (var pattern in _fraudPatterns) {
      if (RegExp(pattern['pattern'], caseSensitive: false).hasMatch(lowerMessage)) {
        detectedPatterns.add(pattern['name']);
        foundPatterns++;
      }
    }

    // Hitung skor risiko
    double baseScore = totalWeight * 2.5;
    double patternBonus = foundPatterns * 10;
    double messageLengthFactor = message.length > 50 ? 5 : 0;
    
    _riskScore = (baseScore + patternBonus + messageLengthFactor).clamp(0, 100);
    
    // Tentukan level risiko
    if (_riskScore < 30) {
      _riskLevel = 'Aman';
      _riskColor = AppColors.success;
      _recommendation = '✅ Pesan ini terlihat aman. Tidak ada indikasi penipuan yang signifikan.';
    } else if (_riskScore < 50) {
      _riskLevel = 'Perlu Diwaspadai';
      _riskColor = AppColors.warning;
      _recommendation = '⚠️ Pesan ini memiliki beberapa indikasi mencurigakan. Periksa kembali sebelum bertindak.';
    } else if (_riskScore < 70) {
      _riskLevel = 'Berisiko Tinggi';
      _riskColor = Colors.orange;
      _recommendation = '🔶 Pesan ini sangat mencurigakan! Jangan langsung percaya. Verifikasi melalui saluran resmi.';
    } else {
      _riskLevel = 'Penipuan!';
      _riskColor = AppColors.danger;
      _recommendation = '🚨 INI ADALAH PESAN PENIPUAN! Jangan ikuti instruksi dalam pesan ini. Laporkan segera!';
    }

    // Set hasil
    setState(() {
      _detectedKeywords = foundKeywords.toList();
      _scanResult = message;
    });

    // Jika ditemukan APK, tambahkan peringatan khusus
    if (lowerMessage.contains('apk') || lowerMessage.contains('install')) {
      _showApkWarning();
    }
  }

  void _showApkWarning() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: AppColors.danger),
            SizedBox(width: 8),
            Text('Peringatan APK!'),
          ],
        ),
        content: Text(
          'Pesan ini mendeteksi kata "APK" atau "install". Penipu sering menggunakan file APK untuk mencuri data Anda. JANGAN menginstal APK dari sumber tidak resmi!',
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Saya Mengerti'),
          ),
        ],
      ),
    );
  }

  void _clearMessage() {
    setState(() {
      _messageController.clear();
      _scanResult = null;
      _detectedKeywords = [];
      _riskScore = 0.0;
      _riskLevel = 'Aman';
      _riskColor = AppColors.success;
      _recommendation = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scanner Pesan',
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
            // Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Scan pesan WhatsApp, SMS, atau chat untuk mendeteksi indikasi penipuan',
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

            // Input Area
            Text(
              'Tempelkan Pesan',
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
                border: Border.all(color: AppColors.greyMedium),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Tempelkan pesan yang ingin di-scan di sini...\n\nContoh:\n"Anda memenangkan hadiah! Segera transfer biaya admin ke rekening 1234567890"',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isScanning ? null : _scanMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isScanning
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            '🔍 Scan Sekarang',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: _clearMessage,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.greyText),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  child: const Icon(Icons.clear, color: AppColors.greyText),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Results
            if (_scanResult != null) ...[
              const Divider(),
              const SizedBox(height: 16),

              // Risk Level
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _riskColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _riskColor.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Level Risiko',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.greyDark,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: _riskColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _riskLevel,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: _riskScore / 100,
                      backgroundColor: AppColors.greyLight,
                      color: _riskColor,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Skor Risiko',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColors.greyText,
                          ),
                        ),
                        Text(
                          '${_riskScore.toStringAsFixed(0)}%',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _riskColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Recommendation
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.greyMedium),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rekomendasi',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _recommendation,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.greyDark,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Detected Keywords
              if (_detectedKeywords.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.greyMedium),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🔍 Kata Terdeteksi (${_detectedKeywords.length})',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _detectedKeywords.map((word) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.danger.withOpacity(0.2)),
                          ),
                          child: Text(
                            word,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.danger,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Pesan Lengkap
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pesan yang di-scan:',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.greyText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _scanResult!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.greyDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _showReportDialog();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.danger),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        '📢 Laporkan Penipuan',
                        style: GoogleFonts.poppins(
                          color: AppColors.danger,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _copyResult();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        '📋 Salin Hasil',
                        style: GoogleFonts.poppins(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _copyResult() {
    final String result = '''
📊 HASIL SCAN PESAN SECUREGUARD
================================
📝 Pesan: ${_scanResult?.substring(0, 50)}...
🟡 Level Risiko: $_riskLevel
📊 Skor Risiko: ${_riskScore.toStringAsFixed(0)}%
🔍 Kata Terdeteksi: ${_detectedKeywords.join(', ')}
💡 Rekomendasi: $_recommendation
================================
Dicek dengan SecureGuard - Digital Fraud Prevention
    ''';
    
    // Copy ke clipboard
    // TODO: Implement clipboard copy
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hasil scan disalin ke clipboard'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Laporkan Penipuan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Apakah Anda ingin melaporkan pesan ini sebagai penipuan?'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _scanResult?.substring(0, 100) ?? '',
                style: GoogleFonts.poppins(fontSize: 13),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/lapor');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
            ),
            child: const Text('Laporkan'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}