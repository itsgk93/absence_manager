import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:absence_manager/providers/absence_provider.dart';
import 'package:absence_manager/widgets/filter_absences.dart';

void main() {
  late AbsenceProvider provider;

  setUp(() {
    provider = AbsenceProvider();
  });

  testWidgets('renders FilterAbsences widget', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => provider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: FilterAbsences(
              onFilterTypeChanged: (type) {},
              onDateRangeChanged: (dateRange) {},
              onReset: () {},
              isFilterApplied: true,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Filter by Date'), findsOneWidget);
    expect(find.text('Absence Type'), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);
  });

  testWidgets('calls onDateRangeChanged callback', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => provider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: FilterAbsences(
              onFilterTypeChanged: (type) {},
              onDateRangeChanged: (dateRange) => {},
              onReset: () {},
              isFilterApplied: true,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Filter by Date'));
  });

  testWidgets('calls onReset callback', (tester) async {
    bool callbackCalled = false;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => provider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: FilterAbsences(
              onFilterTypeChanged: (type) {},
              onDateRangeChanged: (dateRange) {},
              onReset: () => callbackCalled = true,
              isFilterApplied: true,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Reset'));

    expect(callbackCalled, true);
  });
}
