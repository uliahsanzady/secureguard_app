class ReportItem {
  final String title;
  final String description;
  final String? buttonText;
  final String? imageUrl;
  final DateTime timestamp;

  ReportItem({
    required this.title,
    required this.description,
    this.buttonText,
    this.imageUrl,
    required this.timestamp,
  });
}

class EducationItem {
  final String title;
  final String category;
  final String readTime;
  final String description;
  final String? imageUrl;

  EducationItem({
    required this.title,
    required this.category,
    required this.readTime,
    required this.description,
    this.imageUrl,
  });
}

class SearchHistory {
  final String query;
  final String type; // 'phone', 'account', 'link'
  final String detail;
  final DateTime timestamp;

  SearchHistory({
    required this.query,
    required this.type,
    required this.detail,
    required this.timestamp,
  });
}

class CekResult {
  final String number;
  final String status;
  final int securityScore;
  final List<String> tags;
  final Map<String, String> sourceResults;

  CekResult({
    required this.number,
    required this.status,
    required this.securityScore,
    required this.tags,
    required this.sourceResults,
  });
}