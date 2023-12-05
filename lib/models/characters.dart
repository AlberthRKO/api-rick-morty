class Character {
  final String name;
  final String image;
  final String status;

  Character({
    required this.name,
    required this.image,
    required this.status,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
