import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class BahasaScreen extends StatefulWidget {
  const BahasaScreen({super.key});

  @override
  State<BahasaScreen> createState() => _BahasaScreenState();
}

class _BahasaScreenState extends State<BahasaScreen> {
  String _selectedLanguage = 'Indonesia';

  final List<Map<String, String>> languages = [
    {'name': 'Indonesia', 'code': 'id'},
    {'name': 'English', 'code': 'en'},
    {'name': 'Bahasa Malaysia', 'code': 'ms'},
    {'name': '中文 (Chinese)', 'code': 'zh'},
    {'name': '日本語 (Japanese)', 'code': 'ja'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pilih Bahasa',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final lang = languages[index];
          final isSelected = _selectedLanguage == lang['name'];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.greyMedium,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: ListTile(
              leading: isSelected
                  ? const Icon(Icons.check_circle, color: AppColors.primary)
                  : const Icon(Icons.language, color: AppColors.greyText),
              title: Text(
                lang['name']!,
                style: GoogleFonts.poppins(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Aktif',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = lang['name']!;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('✅ Bahasa diubah ke ${lang['name']}'),
                    backgroundColor: AppColors.success,
                  ),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
              },
            ),
          );
        },
      ),
    );
  }
}