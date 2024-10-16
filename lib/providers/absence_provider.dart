import 'package:flutter/material.dart';
import '../models/absence.dart';
import '../models/member.dart';
import '../api/api.dart';

class AbsenceProvider with ChangeNotifier {
  List<Absence> _absences = [];
  List<Member> _members = [];
  List<Absence> _filteredAbsences = [];
  String? _selectedAbsenceType; 
  bool _isLoading = true;
  bool _hasError = false;
  int page = 1;
  final int _pageSize = 10;

  String? get selectedAbsenceType => _selectedAbsenceType;

  List<Absence> get paginatedAbsences {
    if (_filteredAbsences.isEmpty) {
      return [];
    }
    int startIndex = (page - 1) * _pageSize;
    int endIndex = page * _pageSize;
    return _filteredAbsences.isNotEmpty
        ? _filteredAbsences.sublist(
            startIndex,
            endIndex > _filteredAbsences.length
                ? _filteredAbsences.length
                : endIndex,
          )
        : _absences.sublist(
            startIndex,
            endIndex > _absences.length ? _absences.length : endIndex,
          );
  }

  int get totalAbsences => _filteredAbsences.isNotEmpty
      ? _filteredAbsences.length
      : _absences.length;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get hasMoreAbsences =>
      (page * _pageSize) <
      (_filteredAbsences.isNotEmpty
          ? _filteredAbsences.length
          : _absences.length);

  AbsenceProvider() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      _isLoading = true;
      notifyListeners();

      List<dynamic> absencesData = await absences();
      List<dynamic> membersData = await members();

      Map<int, Member> userIdToMemberName = {};
      for (var memberJson in membersData) {
        var member = Member.fromJson(memberJson);
        userIdToMemberName[member.userId] = member;
        _members.add(member);
      }

      _absences = absencesData.map((absenceJson) {
        int userId = absenceJson['userId'];
        String memberName = userIdToMemberName[userId]!.name.toString();
        String memberImage = userIdToMemberName[userId]!.image.toString();
        return Absence.fromJson(absenceJson, memberName, memberImage);
      }).toList();

      _filteredAbsences = List.from(_absences);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _hasError = true;
      print('Error fetching absences: $e');
      notifyListeners();
    }
  }

  void nextPage() {
    if (hasMoreAbsences) {
      page++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (page > 1) {
      page--;
      notifyListeners();
    }
  }

  void filterByType(String type) {
    _selectedAbsenceType = type;

    if (type.isEmpty) {
      _filteredAbsences = List.from(_absences);
    } else {
      _filteredAbsences = _absences
          .where((absence) => absence.type == type.toLowerCase())
          .toList();
    }
    reset();
  }

  void filterByDate(DateTimeRange range) {
    _filteredAbsences = _absences.where((absence) {
      return (absence.startDate.isAtSameMomentAs(range.start) ||
              absence.startDate.isAfter(range.start)) &&
          (absence.endDate.isAtSameMomentAs(range.end) ||
              absence.endDate.isBefore(range.end));
    }).toList();
    reset();
  }

  void reset() {
    page = 1;
    notifyListeners();
  }

  void resetFilters() {
    _filteredAbsences = List.from(_absences);
    _selectedAbsenceType = null;
    reset();
  }
}
