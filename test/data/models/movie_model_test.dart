import 'package:umovieapp/data/models/movie_model.dart';
import 'package:umovieapp/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieModel = MovieModel(
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
  );

  final tMovie = Movie(
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
  );

  test('Should be a subclass of Movie entity', () async {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });
}
