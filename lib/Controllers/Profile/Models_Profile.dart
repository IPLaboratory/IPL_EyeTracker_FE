class ModelsProfile {
  final int id;
  final String name;
  final String? photoPath;
  final String? photoBase64;

  ModelsProfile({
    required this.id,
    required this.name,
    this.photoPath,
    this.photoBase64,
  });

  factory ModelsProfile.fromJson(Map<String, dynamic> json) {
    return ModelsProfile(
      id: json['member']['id'] as int,
      name: json['member']['name'] as String,
      photoPath: json['member']['photoPath'] as String?, // null 가능성 고려
      photoBase64: json['photo'] as String?, // null 가능성 고려
    );
  }
}
