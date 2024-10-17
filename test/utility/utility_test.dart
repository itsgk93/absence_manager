import 'package:flutter_test/flutter_test.dart';
import 'package:absence_manager/models/absence.dart';
import 'package:absence_manager/utility/utility.dart';

void main() {
  group('toPascalCase', () {
    test('should convert text to Pascal Case', () {
      expect(toPascalCase('john_doe'), 'JohnDoe');
      expect(toPascalCase('hello world'), 'HelloWorld');
      expect(toPascalCase('my-name'), 'MyName');
    });

    test('should handle empty strings correctly', () {
      expect(toPascalCase(''), '');
    });
  });

  group('calculateStatus', () {
    test('should return "Requested" when only createdAt is present', () {
      expect(calculateStatus(DateTime.now(), null, null), 'Requested');
    });

    test('should return "Confirmed" when confirmedAt is present', () {
      expect(
          calculateStatus(DateTime.now(), DateTime.now(), null), 'Confirmed');
    });

    test('should return "Rejected" when rejectedAt is present', () {
      expect(calculateStatus(DateTime.now(), null, DateTime.now()), 'Rejected');
    });
  });

  group('generateICal', () {
    test('should generate a valid iCal string', () {
      final absences = [
        Absence(
          crewId: 123,
          memberName: 'John Doe',
          type: 'vacation',
          memberNote: 'Going on vacation',
          startDate: DateTime(2024, 10, 17),
          endDate: DateTime(2024, 10, 20),
          createdAt: DateTime(2024, 10, 1),
          confirmedAt: DateTime(2024, 10, 2),
          rejectedAt: null,
          admitterNote: '',
          userId: 1,
          memberImage: '',
        ),
      ];

      final icalData = generateICal(absences);

      expect(icalData.contains('BEGIN:VEVENT'), true);
      expect(icalData.contains('UID:123@absence_manager.com'), true);
      expect(icalData.contains('SUMMARY:John Doe - Vacation'), true);
    });
  });
}
