import 'dart:io';

import 'package:absence_manager/models/absence.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

String toPascalCase(String text) {
  return text.split(RegExp(r'[_\s-]+')) 
      .map((word) => word.isNotEmpty
          ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
          : '')
      .join('');
}

String calculateStatus(DateTime? createdAt, DateTime? confirmedAt, DateTime? rejectedAt) {
  if (rejectedAt != null) {
    return "Rejected";
  } else if (confirmedAt != null) {
    return "Confirmed";
  } else {
    return "Requested";
  }
}

String generateICal(List<Absence> absences) {
  final StringBuffer ical = StringBuffer();
  ical.writeln('BEGIN:VCALENDAR');
  ical.writeln('VERSION:2.0');
  ical.writeln('CALSCALE:GREGORIAN');

  for (var absence in absences) {
    ical.writeln('BEGIN:VEVENT');
    ical.writeln('UID:${absence.crewId}@absence_manager.com'); 
    ical.writeln('SUMMARY:${absence.memberName} - ${toPascalCase(absence.type)}');
    ical.writeln('DESCRIPTION:${absence.memberNote}');
    ical.writeln('DTSTART:${absence.startDate.toUtc().toIso8601String().replaceAll("-", "").replaceAll(":", "").split(".")[0]}Z'); // Start date
    ical.writeln('DTEND:${absence.endDate.toUtc().toIso8601String().replaceAll("-", "").replaceAll(":", "").split(".")[0]}Z'); // End date
    ical.writeln('STATUS:${calculateStatus(absence.createdAt, absence.confirmedAt, absence.rejectedAt)}');
    ical.writeln('END:VEVENT');
  }

  ical.writeln('END:VCALENDAR');
  return ical.toString();
}

Future<void> exportToICal(List<Absence> absences) async {
  final String icalData = generateICal(absences);
  
  final Directory directory = await getApplicationDocumentsDirectory();
  final String path = '${directory.path}/absences.ics';
  
  final File file = File(path);
  await file.writeAsString(icalData);
  
  await Share.shareXFiles([XFile(path)], text: 'Here is the absence list in iCal format.');
}

