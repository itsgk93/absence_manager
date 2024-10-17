class Absence {
  final String admitterNote;
  final DateTime? confirmedAt;
  final DateTime createdAt;
  final DateTime? rejectedAt;
  final int crewId;
  final DateTime startDate;
  final DateTime endDate;
  final String memberNote;
  final String type;
  final int userId;
  final String memberName;
  final String memberImage;

  Absence({
    required this.admitterNote,
    this.confirmedAt,
    required this.createdAt,
    this.rejectedAt,
    required this.crewId,
    required this.startDate,
    required this.endDate,
    required this.memberNote,
    required this.type,
    required this.userId,
    required this.memberName,
    required this.memberImage,
  });

  factory Absence.fromJson(
      Map<String, dynamic> json, String memberName, String memberImage) {
    return Absence(
      admitterNote: json['admitterNote'] ?? '',
      confirmedAt: json['confirmedAt'] != null
          ? DateTime.parse(json['confirmedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      rejectedAt: json['rejectedAt'] != null
          ? DateTime.parse(json['rejectedAt'])
          : null,
      crewId: json['crewId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      memberNote: json['memberNote'] ?? '',
      type: json['type'] ?? 'Unknown',
      userId: json['userId'],
      memberName: memberName,
      memberImage: memberImage,
    );
  }
}
