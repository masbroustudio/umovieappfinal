import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:umovieapp/common/exception.dart';
import 'package:umovieapp/data/datasources/tv_series_local_data_source.dart';
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

  group('Get TV Series Detail By Id', () {
    final tId = 1;

    test('Return TV Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => tTvSeriesMap);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, tTvSeriesTable);
    });

    test('Return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('Get Watchlist TV series', () {
    test('Return list of Tv Series from DB', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [tTvSeriesMap]);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, [tTvSeriesTable]);
    });
  });

  group('Insert Watchlist', () {
    test('Return success message when insert to database is success (200)',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTvSeries(tTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(tTvSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('Throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTvSeries(tTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(tTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist', () {
    test('Return success message when remove from database is success (200)',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvSeries(tTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(tTvSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('Throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvSeries(tTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(tTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
}
