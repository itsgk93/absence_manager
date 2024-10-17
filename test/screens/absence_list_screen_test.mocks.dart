import 'dart:ui' as _i5;
import 'package:absence_manager/models/absence.dart' as _i3;
import 'package:absence_manager/providers/absence_provider.dart' as _i2;
import 'package:flutter/material.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

class MockAbsenceProvider extends _i1.Mock implements _i2.AbsenceProvider {
  MockAbsenceProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get page => (super.noSuchMethod(
        Invocation.getter(#page),
        returnValue: 0,
      ) as int);

  @override
  set page(int? _page) => super.noSuchMethod(
        Invocation.setter(
          #page,
          _page,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i3.Absence> get paginatedAbsences => (super.noSuchMethod(
        Invocation.getter(#paginatedAbsences),
        returnValue: <_i3.Absence>[],
      ) as List<_i3.Absence>);

  @override
  int get totalAbsences => (super.noSuchMethod(
        Invocation.getter(#totalAbsences),
        returnValue: 0,
      ) as int);

  @override
  bool get isLoading => (super.noSuchMethod(
        Invocation.getter(#isLoading),
        returnValue: false,
      ) as bool);

  @override
  bool get hasError => (super.noSuchMethod(
        Invocation.getter(#hasError),
        returnValue: false,
      ) as bool);

  @override
  bool get hasMoreAbsences => (super.noSuchMethod(
        Invocation.getter(#hasMoreAbsences),
        returnValue: false,
      ) as bool);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  void nextPage() => super.noSuchMethod(
        Invocation.method(
          #nextPage,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void previousPage() => super.noSuchMethod(
        Invocation.method(
          #previousPage,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void filterByType(String? type) => super.noSuchMethod(
        Invocation.method(
          #filterByType,
          [type],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void filterByDate(_i4.DateTimeRange? range) => super.noSuchMethod(
        Invocation.method(
          #filterByDate,
          [range],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void reset() => super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resetFilters() => super.noSuchMethod(
        Invocation.method(
          #resetFilters,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i5.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i5.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
