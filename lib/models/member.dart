class Member {
  final int userId;
  final String name;
  final String image;
  final int crewId; 
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
      image: json['image'] ?? '',
      crewId: json['crewId'],
    );
  }
}
