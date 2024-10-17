import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:absence_manager/providers/absence_provider.dart';
import 'package:absence_manager/widgets/pagination_controls.dart';

void main() {
  late AbsenceProvider provider;

  setUp(() {
    provider = AbsenceProvider();
  });

  testWidgets('renders PaginationControls widget', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => provider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: PaginationControls(provider: provider),
          ),
        ),
      ),
    );

    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });

  testWidgets('Prev button is disabled on first page', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => provider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: PaginationControls(provider: provider),
          ),
        ),
      ),
    );

    final prevButton =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton).first);

    expect(prevButton.onPressed, isNull);
  });

  testWidgets('Prev button is enabled after nextPage', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => provider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: PaginationControls(provider: provider),
          ),
        ),
      ),
    );

    provider.nextPage();
    await tester.pump();

    final prevButton =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton).last);
    expect(prevButton.onPressed, isNotNull);
  });

  testWidgets('calls previousPage', (tester) async {
    provider.page = 2;
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => provider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: PaginationControls(provider: provider),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Prev'));
    await tester.pump();

    expect(provider.page, 1);
  });
}
