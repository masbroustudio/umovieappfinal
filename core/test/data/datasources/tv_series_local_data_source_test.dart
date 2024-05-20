import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/utils/exception.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvSeriesLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('GET Watchlist TV Series', () {
    test('Return list of TvSeries from database', () async {
      // arrange
      when(
        mockDatabaseHelper.getWatchlistTvSeries(),
      ).thenAnswer((_) async => [tTvSeriesMap]);
      // act
      final result = await dataSource.getWatchlist();
      // assert
      expect(result, [tTvSeriesTable]);
    });
  });

  group('GET Watchlist TV Series By Id', () {
    const tId = 1;

    test('Return TV Series Detail Table when data is found', () async {
      // arrange
      when(
        mockDatabaseHelper.getTvSeriesById(tId),
      ).thenAnswer((_) async => tTvSeriesMap);
      // act
      final result = await dataSource.getWatchlistById(tId);
      // assert
      expect(result, tTvSeriesTable);
    });

    test('Return null when data is not found', () async {
      // arrange
      when(
        mockDatabaseHelper.getTvSeriesById(tId),
      ).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getWatchlistById(tId);
      // assert
      expect(result, null);
    });
  });

  group('SAVE Watchlist TV Series', () {
    test('Return success when insert to database is success', () async {
      // arrange
      when(
        mockDatabaseHelper.insertWatchlistTvSeries(tTvSeriesTable),
      ).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(tTvSeriesTable);
      // assert
      expect(result, 'Add to Tv Series Watchlist');
    });

    test('throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(
        mockDatabaseHelper.insertWatchlistTvSeries(tTvSeriesTable),
      ).thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(tTvSeriesTable);
      // assert
      expect(
        () => call,
        throwsA(
          isA<DatabaseException>(),
        ),
      );
    });
  });

  group('REMOVE Watchlist TV Series', () {
    test('Return success when remove from database is success', () async {
      // arrange
      when(
        mockDatabaseHelper.removeWatchlistTvSeries(tTvSeriesTable),
      ).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(tTvSeriesTable);
      // assert
      expect(result, 'Remove from Tv Series Watchlist');
    });

    test('Throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(
        mockDatabaseHelper.removeWatchlistTvSeries(tTvSeriesTable),
      ).thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(tTvSeriesTable);
      // assert
      expect(
        () => call,
        throwsA(
          isA<DatabaseException>(),
        ),
      );
    });
  });
}
