import 'package:absence_manager/models/absence.dart';
import 'package:absence_manager/widgets/pagination_controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/absence_provider.dart';
import 'package:absence_manager/utility/utility.dart';

class AbsenceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AbsenceProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.paginatedAbsences.length,
                itemBuilder: (context, index) {
                  final absence = provider.paginatedAbsences[index];
                  final String status = calculateStatus(
                    absence.createdAt,
                    absence.confirmedAt,
                    absence.rejectedAt,
                  );
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  // ignore: unnecessary_null_comparison
                                  backgroundImage: absence.memberImage != null
                                      ? NetworkImage(absence.memberImage)
                                      : AssetImage('assets/default_avatar.png')
                                          as ImageProvider,
                                  backgroundColor: Colors.grey[200],
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        absence.memberName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        '${toPascalCase(absence.type)}${absence.memberNote.isNotEmpty ? " | " + absence.memberNote : ''}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      Text(
                                        absence.admitterNote.isNotEmpty
                                            ? 'Admitter Note: ${absence.admitterNote}'
                                            : '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        status,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: status == "Rejected"
                                              ? Colors.red
                                              : (status == "Confirmed"
                                                  ? Colors.green
                                                  : Colors.orange),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'From: ${absence.startDate.toLocal().toString().split(' ')[0]}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'To: ${absence.endDate.toLocal().toString().split(' ')[0]}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final List<Absence> absences =
                                    provider.paginatedAbsences;
                                exportToICal(absences);
                              },
                              child: Text('Add to Calendar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4), 
                                minimumSize: Size(100,
                                    20), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      4), 
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            PaginationControls(provider: provider)
          ],
        );
      },
    );
  }
}
