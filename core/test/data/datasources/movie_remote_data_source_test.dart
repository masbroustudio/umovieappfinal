import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:core/utils/exception.dart';

import '../../utils/test_constants.dart';
import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GET Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(
        readJson('dummy_data/movies/now_playing.json'),
      ),
    ).movieList;

    test('Return list of Movie when the response code 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/movie/now_playing?$apiKey'),
        ),
      ).thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/movies/now_playing.json'), 200),
      );
      // act
      final result = await dataSource.getNowPlaying();
      // assert
      expect(
        result,
        equals(tMovieList),
      );
    });

    test('Should throw a ServerException when the response code is 404',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/movie/now_playing?$apiKey'),
        ),
      ).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlaying();
      // assert
      expect(
        () => call,
        throwsA(
          isA<ServerException>(),
        ),
      );
    });
  });

  group('GET Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(
        readJson('dummy_data/movies/top_rated.json'),
      ),
    ).movieList;

    test('Return list of movies when response code 200 ', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/movie/top_rated?$apiKey'),
        ),
      ).thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/movies/top_rated.json'), 200),
      );
      // act
      final result = await dataSource.getTopRated();
      // assert
      expect(result, tMovieList);
    });

    test('Throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/movie/top_rated?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      // act
      final call = dataSource.getTopRated();
      // assert
      expect(
        () => call,
        throwsA(
          isA<ServerException>(),
        ),
      );
    });
  });

  group('GET Popular Movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(
        readJson('dummy_data/movies/popular.json'),
      ),
    ).movieList;

    test('Return list of movies when response code 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/movie/popular?$apiKey'),
        ),
      ).thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/movies/popular.json'), 200),
      );
      // act
      final result = await dataSource.getPopular();
      // assert
      expect(result, tMovieList);
    });

    test('Throw a ServerException when the response code 404', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/movie/popular?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      // act
      final call = dataSource.getPopular();
      // assert
      expect(
        () => call,
        throwsA(
          isA<ServerException>(),
        ),
      );
    });
  });

  group('GET movie detail', () {
    const tId = 1;

    final tMovieDetail = MovieDetailResponse.fromJson(
      json.decode(
        readJson('dummy_data/movies/movie_detail.json'),
      ),
    );

    test('Return movie detail when the response code 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/movie/$tId?$apiKey'),
        ),
      ).thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/movies/movie_detail.json'), 200),
      );
      // act
      final result = await dataSource.getDetail(tId);
      // assert
      expect(
        result,
        equals(tMovieDetail),
      );
    });

    test('Throw Server Exception when the response code 404', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/movie/$tId?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      // act
      final call = dataSource.getDetail(tId);
      // assert
      expect(
        () => call,
        throwsA(
          isA<ServerException>(),
        ),
      );
    });
  });

  group('GET movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(
        readJson('dummy_data/movies/movie_recommendations.json'),
      ),
    ).movieList;
    const tId = 1;

    test('sReturn list of Movie Model when the response code 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/movie/$tId/recommendations?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
            readJson('dummy_data/movies/movie_recommendations.json'), 200),
      );
      // act
      final result = await dataSource.getRecommendation(tId);
      // assert
      expect(
        result,
        equals(tMovieList),
      );
    });

    test('Throw Server Exception when the response code 404', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/movie/$tId/recommendations?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      // act
      final call = dataSource.getRecommendation(tId);
      // assert
      expect(
        () => call,
        throwsA(
          isA<ServerException>(),
        ),
      );
    });
  });

  group('SEARCH movies', () {
    final tSearchResult = MovieResponse.fromJson(
      json.decode(
        readJson('dummy_data/movies/search_spiderman_movie.json'),
      ),
    ).movieList;
    const tQuery = 'Spiderman';

    test('Return list of movies when response code 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/search/movie?$apiKey&query=$tQuery'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
            readJson('dummy_data/movies/search_spiderman_movie.json'), 200),
      );
      // act
      final result = await dataSource.search(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('Throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/search/movie?$apiKey&query=$tQuery'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      // act
      final call = dataSource.search(tQuery);
      // assert
      expect(
        () => call,
        throwsA(
          isA<ServerException>(),
        ),
      );
    });
  });
}
