class Member {
  final int userId;
  final String name;
  final String image; // Optional field for image URL
  final int crewId;   // Optional field for crew ID

  Member({
    required this.userId,
    required this.name,
    required this.image,
    required this.crewId,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      userId: json['userId'],
      name: json['name'],
      image: json['image'] ?? '', // Default to empty string if not provided
      crewId: json['crewId'],
    );
  }
}
