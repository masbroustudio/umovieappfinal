import 'package:flutter_test/flutter_test.dart';
import 'package:umovieapp/data/models/genre_model.dart';
import 'package:umovieapp/data/models/movie_detail_model.dart';
import 'package:umovieapp/domain/entities/movie_detail.dart';

void main() {
  final tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: "/path.jpg",
    budget: 100,
    genres: [GenreModel(id: 1, name: "Action")],
    homepage: "https://google.com",
    id: 1,
    imdbId: "imdb1",
    originalLanguage: "en",
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    revenue: 12000,
    runtime: 120,
    status: "Status",
    tagline: "Tagline",
    title: "Title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final expectedMovieDetail = MovieDetail(
    id: 1,
    originalTitle: "Original Title",
    overview: "Overview",
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    adult: false,
    backdropPath: "/path.jpg",
    genres: [],
    runtime: 120,
    title: 'Original Title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('Entity converts to MovieDetail object', () {
    final movieDetail = tMovieDetailResponse.toEntity();

    expect(movieDetail.id, expectedMovieDetail.id);
    expect(movieDetail.originalTitle, expectedMovieDetail.originalTitle);
    expect(movieDetail.overview, expectedMovieDetail.overview);
    expect(movieDetail.posterPath, expectedMovieDetail.posterPath);
    expect(movieDetail.releaseDate, expectedMovieDetail.releaseDate);
  });
}
