class ModelsProfile {
  final String name;
  final String? photoPath;

  ModelsProfile({
    required this.name,
    this.photoPath,
  });

  factory ModelsProfile.fromJson(Map<String, dynamic> json) {
    return ModelsProfile(
      name: json['name'],
      photoPath: json['photoPath'],
    );
  }
}
