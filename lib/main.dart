import 'package:absence_manager/providers/absence_provider.dart';
import 'package:absence_manager/screens/absence_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AbsenceProvider()),
      ],
      child: MaterialApp(
        title: 'Absence Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AbsenceListScreen(),
      ),
    );
  }
}
