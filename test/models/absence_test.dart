import 'package:flutter_test/flutter_test.dart';
import 'package:absence_manager/models/absence.dart';

void main() {
  group('Absence model tests', () {
    test('Constructor should correctly assign values', () {
      final absence = Absence(
        admitterNote: 'Admitter note here',
        confirmedAt: DateTime.parse('2024-10-15T12:30:00'),
        createdAt: DateTime.parse('2024-10-10T08:30:00'),
        rejectedAt: null,
        crewId: 101,
        startDate: DateTime.parse('2024-10-20'),
        endDate: DateTime.parse('2024-10-25'),
        memberNote: 'Member note here',
        type: 'Vacation',
        userId: 1,
        memberName: 'John Doe',
        memberImage: 'image_url_here',
      );

      expect(absence.admitterNote, 'Admitter note here');
      expect(absence.confirmedAt, DateTime.parse('2024-10-15T12:30:00'));
      expect(absence.createdAt, DateTime.parse('2024-10-10T08:30:00'));
      expect(absence.rejectedAt, null);
      expect(absence.crewId, 101);
      expect(absence.startDate, DateTime.parse('2024-10-20'));
      expect(absence.endDate, DateTime.parse('2024-10-25'));
      expect(absence.memberNote, 'Member note here');
      expect(absence.type, 'Vacation');
      expect(absence.userId, 1);
      expect(absence.memberName, 'John Doe');
      expect(absence.memberImage, 'image_url_here');
    });

    test('fromJson should correctly parse JSON data', () {
      final json = {
        'admitterNote': 'Admitter note from json',
        'confirmedAt': '2024-10-15T12:30:00',
        'createdAt': '2024-10-10T08:30:00',
        'rejectedAt': null,
        'crewId': 102,
        'startDate': '2024-10-20',
        'endDate': '2024-10-25',
        'memberNote': 'Member note from json',
        'type': 'Sickness',
        'userId': 2,
      };

      final absence = Absence.fromJson(
        json,
        'Jane Doe',
        'image_url_from_json',
      );

      expect(absence.admitterNote, 'Admitter note from json');
      expect(absence.confirmedAt, DateTime.parse('2024-10-15T12:30:00'));
      expect(absence.createdAt, DateTime.parse('2024-10-10T08:30:00'));
      expect(absence.rejectedAt, null);
      expect(absence.crewId, 102);
      expect(absence.startDate, DateTime.parse('2024-10-20'));
      expect(absence.endDate, DateTime.parse('2024-10-25'));
      expect(absence.memberNote, 'Member note from json');
      expect(absence.type, 'Sickness');
      expect(absence.userId, 2);
      expect(absence.memberName, 'Jane Doe');
      expect(absence.memberImage, 'image_url_from_json');
    });

    test('fromJson should handle missing or null fields gracefully', () {
      final json = {
        'admitterNote': null,
        'confirmedAt': null,
        'createdAt': '2024-10-10T08:30:00',
        'rejectedAt': null,
        'crewId': 103,
        'startDate': '2024-10-20',
        'endDate': '2024-10-25',
        'memberNote': null,
        'type': null,
        'userId': 3,
      };

      final absence = Absence.fromJson(
        json,
        'Jane Smith',
        'image_url_placeholder',
      );

      expect(absence.admitterNote, ''); 
      expect(absence.confirmedAt, null);
      expect(absence.createdAt, DateTime.parse('2024-10-10T08:30:00'));
      expect(absence.rejectedAt, null);
      expect(absence.crewId, 103);
      expect(absence.startDate, DateTime.parse('2024-10-20'));
      expect(absence.endDate, DateTime.parse('2024-10-25'));
      expect(absence.memberNote, '');
      expect(absence.type, 'Unknown');
      expect(absence.userId, 3);
      expect(absence.memberName, 'Jane Smith');
      expect(absence.memberImage, 'image_url_placeholder');
    });
  });
}
