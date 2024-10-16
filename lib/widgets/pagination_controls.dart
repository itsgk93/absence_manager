import 'package:flutter/material.dart';
import '../providers/absence_provider.dart';

class PaginationControls extends StatelessWidget {
  final AbsenceProvider provider;

  PaginationControls({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: provider.page > 1
                ? () {
                    provider.previousPage();
                  }
                : null,
            child: Text('Prev'),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                provider.page > 1 ? Colors.blue : Colors.grey,
              ),
              foregroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: provider.hasMoreAbsences
                ? () {
                    provider.nextPage();
                  }
                : null,
            child: Text('Next'),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                provider.hasMoreAbsences ? Colors.blue : Colors.grey,
              ),
              foregroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
