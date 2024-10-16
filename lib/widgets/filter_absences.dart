import 'package:flutter/material.dart';

class FilterAbsences extends StatelessWidget {
  final Function(String?) onFilterTypeChanged;
  final Function(DateTimeRange?) onDateRangeChanged;
  final Function() onReset;
  final bool isFilterApplied; 

  FilterAbsences({
    required this.onFilterTypeChanged,
    required this.onDateRangeChanged,
    required this.onReset,
    required this.isFilterApplied, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 180,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 5, 22, 53),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelText: 'Absence Type',
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 5, 22, 53),
                ),
              ),
              items: ['Sickness', 'Vacation']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: onFilterTypeChanged,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              onPressed: () async {
                DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  onDateRangeChanged(picked);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                backgroundColor: const Color.fromARGB(255, 5, 22, 53),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Filter by Date',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 10),
          if (isFilterApplied)
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: onReset,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
