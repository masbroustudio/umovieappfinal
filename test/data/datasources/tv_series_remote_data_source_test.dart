import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:umovieapp/common/exception.dart';
import 'package:umovieapp/data/datasources/tv_series_remote_data_source.dart';
import 'package:umovieapp/data/models/tv_series_detail_model.dart';
import 'package:umovieapp/data/models/tv_series_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=3c2dc9d0d7ccfbae104ee3ffc4f6cd58';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get Now Playing TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/now_playing.json')))
        .tvSeriesList;

    test('Return list of TV Series Model when the response is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlayingTvSeries();
      // assert
      expect(result, equals(tTvSeriesList));
    });

    test('Throw a ServerException when the response is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/popular.json')))
        .tvSeriesList;

    test('Return list of TV Series Model when the response is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/popular.json'), 200));
      // act
      final result = await dataSource.getPopularTvSeries();
      // assert
      expect(result, equals(tTvSeriesList));
    });

    test('Throw a ServerException when the response is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/top_rated.json')))
        .tvSeriesList;

    test('Return list of TV Series Model when response is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvSeries();
      // assert
      expect(result, equals(tTvSeriesList));
    });

    test('Throw a Server Exception when response is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Series Recommendations', () {
    final tMovieList = TvSeriesResponse.fromJson(json.decode(
            readJson('dummy_data/tv_series/tv_series_recommendations.json')))
        .tvSeriesList;
    final tId = 1;

    test('Return list of TV Series Model when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/tv_series_recommendations.json'),
              200));
      // act
      final result = await dataSource.getTvSeriesRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('Throw Server Exception when response code 404 or other', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Series Detail', () {
    final tId = 1;
    final tTvSeriesDetail = TvSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/tv_series_detail.json')));

    test('Return tv series detail when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/tv_series_detail.json'), 200));
      // act
      final result = await dataSource.getTvSeriesDetail(tId);
      // assert
      expect(result, equals(tTvSeriesDetail));
    });

    test('Throw Server Exception when response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search Tv Series', () {
    final tSearchResult = TvSeriesResponse.fromJson(json.decode(
      readJson('dummy_data/tv_series/search_example_tv_series.json'),
    )).tvSeriesList;
    final tQuery = 'Game of Thrones';

    test('Rreturn list of tv series when response is 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_series/search_example_tv_series.json'),
          200,
        ),
      );
      // act
      final result = await dataSource.searchTvSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('Throw ServerException when response is other than 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
