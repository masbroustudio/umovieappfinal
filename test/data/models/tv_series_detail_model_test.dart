import 'package:flutter_test/flutter_test.dart';
import 'package:umovieapp/data/models/genre_model.dart';
import 'package:umovieapp/data/models/season_model.dart';
import 'package:umovieapp/data/models/tv_series_detail_model.dart';

void main() {
  group('TvSeriesDetailResponse', () {
    final int testId = 1;
    final bool testInProduction = false;
    final List<String> testLanguages = ["en"];
    final String testLastAirDate = "2023-05-11";
    final String testName = "Test Series";
    final int testNumberOfEpisodes = 10;
    final int testNumberOfSeasons = 2;
    final List<String> testOriginCountry = ["US"];
    final String testOriginalLanguage = "en";
    final String testOriginalName = "Test Series (Original)";
    final String testOverview = "A great series";
    final double testPopularity = 8.5;
    final String? testPosterPath = "/path/to/poster.jpg";
    final List<SeasonModel> testSeasons = [
      SeasonModel(
          id: 1,
          name: "Season 1",
          overview: '',
          posterPath: '',
          seasonNumber: 1,
          airDate: '',
          episodeCount: 1)
    ];
    final String testStatus = "Returning";
    final String testTagline = "The best series ever!";
    final String testType = "Scripted";
    final double testVoteAverage = 9.0;
    final int testVoteCount = 100;
    final String? testBackdropPath = "/path/to/backdrop.jpg";
    final String testFirstAirDate = "2020-01-01";
    final List<GenreModel> testGenres = [GenreModel(id: 28, name: "Action")];
    final String testHomepage = "https://google.com";

    final Map<String, dynamic> testJson = {
      "id": testId,
      "in_production": testInProduction,
      "languages": testLanguages,
      "last_air_date": testLastAirDate,
      "name": testName,
      "number_of_episodes": testNumberOfEpisodes,
      "number_of_seasons": testNumberOfSeasons,
      "origin_country": testOriginCountry,
      "original_language": testOriginalLanguage,
      "original_name": testOriginalName,
      "overview": testOverview,
      "popularity": testPopularity,
      "poster_path": testPosterPath,
      "seasons": testSeasons.map((x) => x.toJson()).toList(),
      "status": testStatus,
      "tagline": testTagline,
      "type": testType,
      "vote_average": testVoteAverage,
      "vote_count": testVoteCount,
      "backdrop_path": testBackdropPath,
      "first_air_date": testFirstAirDate,
      "genres": testGenres.map((x) => x.toJson()).toList(),
      "homepage": testHomepage,
    };

    test('fromJson creates a TvSeriesDetailResponse object', () {
      final response = TvSeriesDetailResponse.fromJson(testJson);

      expect(response.id, testId);
      expect(response.inProduction, testInProduction);
      expect(response.languages, testLanguages);
      expect(response.lastAirDate, testLastAirDate);
      expect(response.name, testName);
      expect(response.numberOfEpisodes, testNumberOfEpisodes);
      expect(response.numberOfSeasons, testNumberOfSeasons);
      expect(response.originCountry, testOriginCountry);
      expect(response.originalLanguage, testOriginalLanguage);
      expect(response.originalName, testOriginalName);
      expect(response.overview, testOverview);
      expect(response.popularity, testPopularity);
      expect(response.posterPath, testPosterPath);
      expect(response.seasons, testSeasons);
      expect(response.status, testStatus);
      expect(response.tagline, testTagline);
      expect(response.type, testType);
      expect(response.voteAverage, testVoteAverage);
      expect(response.voteCount, testVoteCount);
    });
  });
}
