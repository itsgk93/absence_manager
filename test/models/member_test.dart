import 'package:flutter_test/flutter_test.dart';
import 'package:absence_manager/models/member.dart';

void main() {
  group('Member Model', () {
    test('Member.fromJson creates a valid instance with all fields', () {
      final json = {
        'userId': 1,
        'name': 'John Doe',
        'image': 'profile_image_url',
        'crewId': 123,
      };

      final member = Member.fromJson(json);

      expect(member.userId, 1);
      expect(member.name, 'John Doe');
      expect(member.image, 'profile_image_url');
      expect(member.crewId, 123);
    });

    test('Member.fromJson handles missing optional fields', () {
      final json = {
        'userId': 2,
        'name': 'Jane Smith',
        'crewId': 456,
      };

      final member = Member.fromJson(json);

      expect(member.userId, 2);
      expect(member.name, 'Jane Smith');
      expect(member.image, '');  
      expect(member.crewId, 456);
    });
  });
}
