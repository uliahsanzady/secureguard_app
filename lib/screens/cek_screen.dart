import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/data_models.dart';
import '../services/api_service.dart';
import 'dashboard_screen.dart';
import 'edukasi_screen.dart';
import 'profil_screen.dart';
import 'cek_result_screen.dart';

class CekScreen extends StatefulWidget {
  const CekScreen({super.key});

  @override
  State<CekScreen> createState() => _CekScreenState();
}

class _CekScreenState extends State<CekScreen> {
  int _currentIndex = 1;
  String _selectedType = 'Nomor';
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  
  List<SearchHistory> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    // TODO: Load from SharedPreferences
    setState(() {
      _history = [
        SearchHistory(
          query: '0812 3456 7890',
          type: 'phone',
          detail: 'Nomor Telepon • 2 jam yang lalu',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        SearchHistory(
          query: '1122334455',
          type: 'account',
          detail: 'Rekening BCA • 1 hari yang lalu',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];
    });
  }

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
                'Credibility Check',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Cek Kredibilitas',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pastikan nomor, rekening, atau tautan aman sebelum bertransaksi.',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.verified_outlined,
                      color: AppColors.success,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Data terintegrasi dengan CekRekening.id & Google Safe Browsing',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.greyDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildTypeButton('Nomor'),
                  _buildTypeButton('Rekening'),
                  _buildTypeButton('Tautan'),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  enabled: !_isLoading,
                  decoration: InputDecoration(
                    hintText: _getHintText(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    suffixIcon: _isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: _handleSearch,
                            icon: const Icon(Icons.search, color: AppColors.primary),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Cek Sekarang',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Riwayat Pencarian',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _history.clear();
                      });
                    },
                    child: Text(
                      'Hapus Semua',
                      style: GoogleFonts.poppins(
                        color: AppColors.danger,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_history.isNotEmpty)
                ..._history.map((item) => _buildHistoryItem(item)),
              const SizedBox(height: 24),
              _buildPopularReports(),
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
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EdukasiScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  String _getHintText() {
    switch (_selectedType) {
      case 'Nomor':
        return 'Masukkan nomor telepon (contoh: 0812 3456 7890)';
      case 'Rekening':
        return 'Masukkan nomor rekening (contoh: 1234567890)';
      case 'Tautan':
        return 'Masukkan tautan (contoh: https://example.com)';
      default:
        return 'Masukkan untuk dicek...';
    }
  }

  Widget _buildTypeButton(String label) {
    final isSelected = _selectedType == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedType = label;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.greyLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
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
      ),
    );
  }

  Future<void> _handleSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan data terlebih dahulu'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      Map<String, dynamic> result;
      
      switch (_selectedType) {
        case 'Rekening':
          result = await ApiService.cekRekening(query);
          break;
        case 'Tautan':
          result = await ApiService.cekTautan(query);
          break;
        default:
          result = await ApiService.cekNomorTelepon(query);
          break;
      }

      setState(() {
        _isLoading = false;
      });

      setState(() {
        _history.insert(0, SearchHistory(
          query: query,
          type: _selectedType.toLowerCase(),
          detail: '$_selectedType • ${_getTimeAgo()}',
          timestamp: DateTime.now(),
        ));
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CekResultScreen(),
          settings: RouteSettings(
            arguments: {
              'query': query,
              'type': _selectedType,
              'result': result,
            },
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  String _getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(DateTime.now().subtract(const Duration(hours: 1)));
    if (difference.inMinutes < 1) return 'Baru saja';
    if (difference.inMinutes < 60) return '${difference.inMinutes} menit yang lalu';
    if (difference.inHours < 24) return '${difference.inHours} jam yang lalu';
    return '${difference.inDays} hari yang lalu';
  }

  Widget _buildHistoryItem(SearchHistory item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.greyMedium),
        ),
      ),
      child: Row(
        children: [
          Icon(
            item.type == 'phone' ? Icons.phone : 
            item.type == 'account' ? Icons.account_balance : 
            Icons.link,
            color: AppColors.greyText,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.query,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  item.detail,
                  style: GoogleFonts.poppins(
                    color: AppColors.greyText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _history.remove(item);
              });
            },
            icon: const Icon(Icons.close, color: AppColors.greyText, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularReports() {
    return FutureBuilder(
      future: ApiService.getPopularReports(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Text(
            'Gagal memuat data populer',
            style: GoogleFonts.poppins(color: AppColors.danger),
          );
        }

        final reports = snapshot.data ?? [];
        if (reports.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sedang Populer Dilaporkan',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...reports.map((report) => _buildPopularItem(
              title: report['title'] ?? 'Unknown',
              number: report['number'] ?? 'N/A',
              reports: '${report['reports'] ?? 0} laporan minggu ini',
              color: _getColorFromHex(report['color'] ?? '#F44336'),
            )),
          ],
        );
      },
    );
  }

  Color _getColorFromHex(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceAll('#', '0xFF')));
    } catch (e) {
      return AppColors.danger;
    }
  }

  Widget _buildPopularItem({
    required String title,
    required String number,
    required String reports,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyMedium),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  number,
                  style: GoogleFonts.poppins(
                    color: AppColors.greyDark,
                    fontSize: 13,
                  ),
                ),
                Text(
                  reports,
                  style: GoogleFonts.poppins(
                    color: AppColors.greyText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}