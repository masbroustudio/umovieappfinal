import 'dart:io';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/domain/entities/movie.dart';

import '../../dummy_data/movies/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  const tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Movies Now Playing', () {
    test('Return remote data when the call to remote data source is success',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getNowPlaying(),
      ).thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(
        mockRemoteDataSource.getNowPlaying(),
      );
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('Return server failure when the call to remote data source is failed',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying()).thenThrow(ServerException());
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
        'Return connection failure when the device is not connected to internet',
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
      verify(mockRemoteDataSource.getNowPlaying());
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
      verify(mockRemoteDataSource.getNowPlaying());
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

  group('Popular Movies', () {
    test('Return movie list when call to data source is success', () async {
      // arrange
      when(
        mockRemoteDataSource.getPopular(),
      ).thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getPopular();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('Return ServerFailure when call to data source is failed', () async {
      // arrange
      when(mockRemoteDataSource.getPopular()).thenThrow(
        ServerException(),
      );
      // act
      final result = await repository.getPopular();
      // assert
      expect(
        result,
        const Left(
          ServerFailure(''),
        ),
      );
    });

    test(
        'Return ConnectionFailure when device is not connected to the internet',
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
      expect(
        result,
        const Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
    });

    test(
        'Return common failure when the call to remote data source certificate verify is failed',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular()).thenThrow(
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

  group('Top Rated Movies', () {
    test('Return movie list when call to data source is success', () async {
      // arrange
      when(
        mockRemoteDataSource.getTopRated(),
      ).thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getTopRated();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('Return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRated();
      // assert
      expect(
        result,
        const Left(
          ServerFailure(''),
        ),
      );
    });

    test(
        'Return ConnectionFailure when device is not connected to the internet',
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
      expect(
        result,
        const Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
    });

    test(
        'Return Common Failure when the call to remote data source certificate verify is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getTopRated(),
      ).thenThrow(const TlsException());
      // act
      final result = await repository.getTopRated();
      // assert
      verify(mockRemoteDataSource.getTopRated());
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

  group('GET Movie Detail', () {
    const tId = 1;
    const tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test('Return Movie data when the call to remote data source is success',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getDetail(tId),
      ).thenAnswer(
        (_) async => tMovieResponse,
      );
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(mockRemoteDataSource.getDetail(tId));
      expect(
        result,
        equals(
          const Right(
            testMovieDetail,
          ),
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
        'Return ConnectionFailure when device is not connected to the internet',
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
      verify(mockRemoteDataSource.getDetail(tId));
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
      verify(mockRemoteDataSource.getDetail(tId));
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

  group('GET Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    const tId = 1;

    test('Return data movie list when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getRecommendation(tId)).thenAnswer(
        (_) async => tMovieList,
      );
      // act
      final result = await repository.getRecommendation(tId);
      // assert
      verify(mockRemoteDataSource.getRecommendation(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test('Return Server Failure when the call to remote data source is failed',
        () async {
      // arrange
      when(
        mockRemoteDataSource.getRecommendation(tId),
      ).thenThrow(ServerException());
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
            ServerFailure(''),
          ),
        ),
      );
    });

    test(
        'Return ConnectionFailure when device is not connected to the internet',
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
      verify(mockRemoteDataSource.getRecommendation(tId));
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
        mockRemoteDataSource.getRecommendation(tId),
      ).thenThrow(
        const TlsException(),
      );
      // act
      final result = await repository.getRecommendation(tId);
      // assert
      verify(mockRemoteDataSource.getRecommendation(tId));
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

  group('Watchlist', () {
    test('Return watchlist status whether data is found', () async {
      // arrange
      const tId = 1;
      when(
        mockLocalDataSource.getWatchlistById(tId),
      ).thenAnswer(
        (_) async => null,
      );
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });

    test('Return all movies watchlist', () async {
      // arrange
      when(
        mockLocalDataSource.getWatchlist(),
      ).thenAnswer(
        (_) async => [testMovieTable],
      );
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });

    group('save watchlist', () {
      test('should return success message when saving successful', () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(testMovieTable))
            .thenAnswer((_) async => 'Added to Watchlist');
        // act
        final result = await repository.saveWatchlist(testMovieDetail);
        // assert
        expect(result, const Right('Added to Watchlist'));
      });

      test('should return DatabaseFailure when saving unsuccessful', () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(testMovieTable))
            .thenThrow(DatabaseException('Failed to add watchlist'));
        // act
        final result = await repository.saveWatchlist(testMovieDetail);
        // assert
        expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
      });
    });

    test('Remove watchlist', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(
          testMovieTable,
        ),
      ).thenAnswer(
        (_) async => 'Removed from Watchlist',
      );
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, const Right('Removed from Watchlist'));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Search Movies', () {
    const tQuery = 'spiderman';

    test('Return movie list when call to data source is success', () async {
      // arrange
      when(
        mockRemoteDataSource.search(tQuery),
      ).thenAnswer(
        (_) async => tMovieModelList,
      );
      // act
      final result = await repository.search(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('Return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.search(tQuery)).thenThrow(
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
        'Return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.search(tQuery)).thenThrow(
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
        'Return Common Failure when the call to remote data source certificate verify is failed',
        () async {
      // arrange
      when(mockRemoteDataSource.search(tQuery)).thenThrow(
        const TlsException(),
      );
      // act
      final result = await repository.search(tQuery);
      // assert
      verify(mockRemoteDataSource.search(tQuery));
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
}
