class AppPostersModel {
  final int id;
  final String title;
  final String imagePath;
  final String linkUrl;
  final int isActive;

  AppPostersModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.linkUrl,
    required this.isActive,
  });

  factory AppPostersModel.fromJson(Map<String, dynamic> json) {
    return AppPostersModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imagePath: json['image_path'] ?? '',
      linkUrl: json['link_url'] ?? '',
      isActive: json['is_active'] ?? 0,
    );
  }
}
