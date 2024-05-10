// Mocks generated by Mockito 5.4.4 from annotations
// in umovieapp/test/presentation/pages/tv_series/top_rated_tv_series_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:ui' as _i8;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;
import 'package:umovieapp/common/state_enum.dart' as _i5;
import 'package:umovieapp/domain/entities/tv_series.dart' as _i4;
import 'package:umovieapp/domain/usecases/tv_series/get_top_rated_tv_series.dart'
    as _i2;
import 'package:umovieapp/presentation/provider/tv_series/top_rated_tv_series_notifier.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetTopRatedTvSeries_0 extends _i1.SmartFake
    implements _i2.GetTopRatedTvSeries {
  _FakeGetTopRatedTvSeries_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TopRatedTvSeriesNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedTvSeriesNotifier extends _i1.Mock
    implements _i3.TopRatedTvSeriesNotifier {
  MockTopRatedTvSeriesNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTopRatedTvSeries get getTopRatedTvSeries => (super.noSuchMethod(
        Invocation.getter(#getTopRatedTvSeries),
        returnValue: _FakeGetTopRatedTvSeries_0(
          this,
          Invocation.getter(#getTopRatedTvSeries),
        ),
      ) as _i2.GetTopRatedTvSeries);

  @override
  List<_i4.TvSeries> get tvSeries => (super.noSuchMethod(
        Invocation.getter(#tvSeries),
        returnValue: <_i4.TvSeries>[],
      ) as List<_i4.TvSeries>);

  @override
  _i5.RequestState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i5.RequestState.Empty,
      ) as _i5.RequestState);

  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.getter(#message),
        ),
      ) as String);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i7.Future<void> fetchTopRatedTvSeries() => (super.noSuchMethod(
        Invocation.method(
          #fetchTopRatedTvSeries,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  void addListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
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
