import 'package:absence_manager/providers/absence_provider.dart';
import 'package:absence_manager/screens/absence_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'absence_list_screen_test.mocks.dart';

@GenerateMocks([AbsenceProvider])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAbsenceProvider mockProvider;

  setUp(() {
    mockProvider = MockAbsenceProvider();
  });

  testWidgets('shows CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(mockProvider.isLoading).thenReturn(true);

    await tester.pumpWidget(
      ChangeNotifierProvider<AbsenceProvider>.value(
        value: mockProvider,
        child: MaterialApp(home: AbsenceListScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when there is an error',
      (WidgetTester tester) async {
    when(mockProvider.isLoading).thenReturn(false);
    when(mockProvider.hasError).thenReturn(true);
    await tester.pumpWidget(
      ChangeNotifierProvider<AbsenceProvider>.value(
        value: mockProvider,
        child: MaterialApp(home: AbsenceListScreen()),
      ),
    );

    expect(find.text('Error loading absences.'), findsOneWidget);
  });

  testWidgets('displays no absences found message when list is empty',
      (WidgetTester tester) async {
    when(mockProvider.isLoading).thenReturn(false);
    when(mockProvider.hasError).thenReturn(false);
    when(mockProvider.totalAbsences).thenReturn(0);
    when(mockProvider.selectedAbsenceType).thenReturn(null);
    when(mockProvider.paginatedAbsences).thenReturn([]);

    await tester.pumpWidget(
      ChangeNotifierProvider<AbsenceProvider>.value(
        value: mockProvider,
        child: MaterialApp(home: AbsenceListScreen()),
      ),
    );
    expect(
        find.text('No absences found for selected criteria'), findsOneWidget);
  });
}
