import 'dart:convert';
import 'package:flutter/services.dart'; // Import this for rootBundle

Future<List<dynamic>> readJsonFile(String path) async {
  String content = await rootBundle.loadString(path); // Use loadString instead of File
  Map<String, dynamic> data = jsonDecode(content);
  return data['payload'];
}

Future<List<dynamic>> absences() async {
  return await readJsonFile('assets/json_files/absences.json'); // Update the path
}

Future<List<dynamic>> members() async {
  return await readJsonFile('assets/json_files/members.json'); // Update the path
}
