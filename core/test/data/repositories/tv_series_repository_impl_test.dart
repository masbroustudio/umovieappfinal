import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/entities/tv_series.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('GET Now Playing TV Series', () {
    test('Return remote data when the call to remote data source is success',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getNowPlaying(),
      ).thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(
        mockRemoteDataSource.getNowPlaying(),
      );
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('Return Server Failure when the call to remote data source is failed',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying()).thenThrow(
        ServerException(),
      );
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      expect(
        result,
        equals(
          const Left(
            ServerFailure(''),
          ),
        ),
      );
    });

    test(
        'Return Connection Failure when the device is not connected to internet',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getNowPlaying(),
      ).thenThrow(
        const SocketException('Failed to connect to the network'),
      );
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(
        mockRemoteDataSource.getNowPlaying(),
      );
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });

    test(
        'Return Common Failure when the call to remote data source certificate verify is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getNowPlaying(),
      ).thenThrow(
        const TlsException(),
      );
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(
        mockRemoteDataSource.getNowPlaying(),
      );
      expect(
        result,
        equals(
          const Left(
            CommonFailure('Certificated Not Valid:\n'),
          ),
        ),
      );
    });
  });

  group('GET Top Rated TV Series', () {
    test('Return remote data when the call to remote data source is success',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getTopRated(),
      ).thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getTopRated();
      // assert
      verify(
        mockRemoteDataSource.getTopRated(),
      );
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('Return Server Failure when the call to remote data source is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getTopRated(),
      ).thenThrow(
        ServerException(),
      );
      // act
      final result = await repository.getTopRated();
      // assert
      verify(mockRemoteDataSource.getTopRated());
      expect(
        result,
        equals(
          const Left(
            ServerFailure(''),
          ),
        ),
      );
    });

    test(
        'Return Connection Failure when the device is not connected to internet',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getTopRated(),
      ).thenThrow(
        const SocketException('Failed to connect to the network'),
      );
      // act
      final result = await repository.getTopRated();
      // assert
      verify(
        mockRemoteDataSource.getTopRated(),
      );
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });

    test(
        'Return Common Failure when the call to remote data source ceritificate verify is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getTopRated(),
      ).thenThrow(
        const TlsException(),
      );
      // act
      final result = await repository.getTopRated();
      // assert
      verify(
        mockRemoteDataSource.getTopRated(),
      );
      expect(
        result,
        equals(
          const Left(
            CommonFailure('Certificated Not Valid:\n'),
          ),
        ),
      );
    });
  });

  group('GET Popular TV Series', () {
    test('Return remote data when the call to remote data source is success',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getPopular(),
      ).thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getPopular();
      // assert
      verify(
        mockRemoteDataSource.getPopular(),
      );
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('Return Server Failure when the call to remote data source is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getPopular(),
      ).thenThrow(
        ServerException(),
      );
      // act
      final result = await repository.getPopular();
      // assert
      verify(
        mockRemoteDataSource.getPopular(),
      );
      expect(
        result,
        equals(
          const Left(
            ServerFailure(''),
          ),
        ),
      );
    });

    test(
        'Return Connection Failure when the device is not connected to internet',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getPopular(),
      ).thenThrow(
        const SocketException('Failed to connect to the network'),
      );
      // act
      final result = await repository.getPopular();
      // assert
      verify(
        mockRemoteDataSource.getPopular(),
      );
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });

    test(
        'Return Common Failure when the call to remote data source certificate verify is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getPopular(),
      ).thenThrow(
        const TlsException(),
      );
      // act
      final result = await repository.getPopular();
      // assert
      verify(
        mockRemoteDataSource.getPopular(),
      );
      expect(
        result,
        equals(
          const Left(
            CommonFailure('Certificated Not Valid:\n'),
          ),
        ),
      );
    });
  });

  group('GET Detail TV Series', () {
    const tId = 1;

    test('Return TV Series data when the call to remote data source is success',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getDetail(tId),
      ).thenAnswer((_) async => tTvSeriesResponse);
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(mockRemoteDataSource.getDetail(tId));
      expect(
        result,
        equals(
          const Right(tTvSeriesDetail),
        ),
      );
    });

    test('Return Server Failure when the call to remote data source is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getDetail(tId),
      ).thenThrow(
        ServerException(),
      );
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(mockRemoteDataSource.getDetail(tId));
      expect(
        result,
        equals(
          const Left(
            ServerFailure(''),
          ),
        ),
      );
    });

    test(
        'Return Connection Failure when the device is not connected to internet',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getDetail(tId),
      ).thenThrow(
        const SocketException('Failed to connect to the network'),
      );
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(
        mockRemoteDataSource.getDetail(tId),
      );
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });

    test(
        'Return Common Failure when the call to remote data source certificate verify is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getDetail(tId),
      ).thenThrow(
        const TlsException(),
      );
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(
        mockRemoteDataSource.getDetail(tId),
      );
      expect(
        result,
        equals(
          const Left(
            CommonFailure('Certificated Not Valid:\n'),
          ),
        ),
      );
    });
  });

  group('GET Recommendations TV Series', () {
    final tTvSeriesList = <TvSeriesModel>[];
    const tId = 1;

    test('Return data Tv Series List when the call is success', () async {
      // arrange
      when(
        mockRemoteDataSource.getRecommendation(tId),
      ).thenAnswer((_) async => tTvSeriesList);

      // act
      final result = await repository.getRecommendation(tId);

      // assert
      verify(
        mockRemoteDataSource.getRecommendation(tId),
      );
      final resultList = result.getOrElse(() => []);

      expect(
        resultList,
        equals(tTvSeriesList),
      );
    });

    test('Return Server Failure when call to remote data source is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getRecommendation(tId),
      ).thenThrow(
        ServerException(),
      );
      // act
      final result = await repository.getRecommendation(tId);
      // assertbuild runner
      verify(
        mockRemoteDataSource.getRecommendation(tId),
      );
      expect(
        result,
        equals(
          const Left(
            ServerFailure(''),
          ),
        ),
      );
    });

    test(
        'Return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getRecommendation(tId),
      ).thenThrow(
        const SocketException('Failed to connect to the network'),
      );
      // act
      final result = await repository.getRecommendation(tId);
      // assert
      verify(
        mockRemoteDataSource.getRecommendation(tId),
      );
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });

    test(
        'Return Common Failure when call to remote data source certificate verify is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getRecommendation(tId),
      ).thenThrow(
        const TlsException(),
      );
      // act
      final result = await repository.getRecommendation(tId);
      // assertbuild runner
      verify(
        mockRemoteDataSource.getRecommendation(tId),
      );
      expect(
        result,
        equals(
          const Left(
            CommonFailure('Certificated Not Valid:\n'),
          ),
        ),
      );
    });
  });

  group('GET Watchlist Status', () {
    test('Return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(
        mockLocalDataSource.getWatchlistById(tId),
      ).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('GET All Watchlist TV Series', () {
    test('Return TV Series List', () async {
      // arrange
      when(
        mockLocalDataSource.getWatchlist(),
      ).thenAnswer((_) async => [tTvSeriesTable]);
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [tWatchlistTvSeries]);
    });

    test('Return Database Dailure when get data failed', () async {
      // arrange
      when(
        mockLocalDataSource.getWatchlist(),
      ).thenThrow(
        DatabaseException('Failed to remove watchlist'),
      );
      // act
      final result = await repository.getWatchlist();
      // assert
      expect(
        result,
        const Left(
          DatabaseFailure('Failed to remove watchlist'),
        ),
      );
    });
  });

  group('SAVE Watchlist TV Series', () {
    test('Return success message when saving successful', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(tTvSeriesTable),
      ).thenAnswer((_) async => 'Add to Movie Watchlist');
      // act
      final result = await repository.saveWatchlist(tTvSeriesDetail);
      // assert
      expect(
        result,
        const Right('Add to Movie Watchlist'),
      );
    });

    test('Return Database Failure when saving failed', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(tTvSeriesTable),
      ).thenThrow(
        DatabaseException('Failed to add watchlist'),
      );
      // act
      final result = await repository.saveWatchlist(tTvSeriesDetail);
      // assert
      expect(
        result,
        const Left(
          DatabaseFailure('Failed to add watchlist'),
        ),
      );
    });
  });

  group('REMOVE Watchlist TV Series', () {
    test('Return success message when remove successful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(tTvSeriesTable),
      ).thenAnswer((_) async => 'Remove from Movie Watchlist');
      // act
      final result = await repository.removeWatchlist(tTvSeriesDetail);
      // assert
      expect(
        result,
        const Right('Remove from Movie Watchlist'),
      );
    });

    test('Return Database Failure when remove failed', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(tTvSeriesTable),
      ).thenThrow(
        DatabaseException('Failed to remove watchlist'),
      );
      // act
      final result = await repository.removeWatchlist(tTvSeriesDetail);
      // assert
      expect(
        result,
        const Left(
          DatabaseFailure('Failed to remove watchlist'),
        ),
      );
    });
  });

  group('GET Detail Season', () {
    const tId = 1;
    const tSeasonNumber = 1;

    test('Return Season data when the call to remote data source is success',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber),
      ).thenAnswer((_) async => tSeasonDetailResponse);
      // act
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(
        mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber),
      );
      expect(
        result,
        equals(
          const Right(tSeasonDetail),
        ),
      );
    });

    test('Return Server Failure when the call to remote data source is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getDetail(tId),
      ).thenThrow(
        ServerException(),
      );
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(
        mockRemoteDataSource.getDetail(tId),
      );
      expect(
        result,
        equals(
          const Left(
            ServerFailure(''),
          ),
        ),
      );
    });

    test(
        'Return Connection Failure when the device is not connected to internet',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber),
      ).thenThrow(
        const SocketException('Failed to connect to the network'),
      );
      // act
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(
        mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber),
      );
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });

    test(
        'Return Common Failure when the call to remote data source certificate verify is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber),
      ).thenThrow(
        const TlsException(),
      );
      // act
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(
        mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber),
      );
      expect(
        result,
        equals(
          const Left(
            CommonFailure('Certificated Not Valid:\n'),
          ),
        ),
      );
    });
  });

  group('Search TV Series', () {
    const tQuery = 'Greek';

    test('Return tv series list when call to data source is success', () async {
      // arrange
      when(
        mockRemoteDataSource.search(tQuery),
      ).thenAnswer((_) async => tTvSeriesModelList);

      // act
      final result = await repository.search(tQuery);

      // assert
      final resultList = result.getOrElse(() => []);

      expect(resultList, tTvSeriesList);
    });

    test('Return ServerFailure when call to data source is failed', () async {
      // arrange
      when(
        mockRemoteDataSource.search(tQuery),
      ).thenThrow(
        ServerException(),
      );
      // act
      final result = await repository.search(tQuery);
      // assert
      expect(
        result,
        const Left(
          ServerFailure(''),
        ),
      );
    });

    test(
        'Return Connection Failure when device is not connected to the internet',
        () async {
      // arrange
      when(
        mockRemoteDataSource.search(tQuery),
      ).thenThrow(
        const SocketException('Failed to connect to the network'),
      );
      // act
      final result = await repository.search(tQuery);
      // assert
      expect(
        result,
        const Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
    });

    test(
        'Return Common Failure when call to data source certificate verify is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.search(tQuery),
      ).thenThrow(
        const TlsException(),
      );
      // act
      final result = await repository.search(tQuery);
      // assert
      expect(
        result,
        const Left(
          CommonFailure('Certificated Not Valid:\n'),
        ),
      );
    });
  });
}
