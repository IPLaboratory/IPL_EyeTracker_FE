class ModelsProfile {
  final int id;
  final String name;
  final String? photoPath;

  ModelsProfile({
    required this.id,
    required this.name,
    this.photoPath,
  });

  factory ModelsProfile.fromJson(Map<String, dynamic> json) {
    return ModelsProfile(
      id : json['id'],
      name: json['name'],
      photoPath: json['photoPath'],
    );
  }
}
