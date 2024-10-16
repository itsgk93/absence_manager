import 'package:absence_manager/widgets/absence_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/absence_provider.dart';
import '../widgets/filter_absences.dart';

class AbsenceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absence Manager'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<AbsenceProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.hasError) {
            return Center(child: Text('Error loading absences.'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterAbsences(
                  onFilterTypeChanged: (type) {
                    provider.filterByType(type!);
                  },
                  onDateRangeChanged: (dateRange) {
                    if (dateRange != null) {
                      provider.filterByDate(dateRange);
                    }
                  },
                  onReset: () {
                    provider.resetFilters();
                  },
                  isFilterApplied: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Absences: ${provider.totalAbsences}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  child: provider.paginatedAbsences.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text("No absences found for selected criteria"))
                      : AbsenceList(), 
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
