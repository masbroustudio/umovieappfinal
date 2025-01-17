import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTopRatedMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];

  test('GET list of top rated movies from repository', () async {
    // arrange
    when(
      mockMovieRepository.getTopRated(),
    ).thenAnswer(
      (_) async => Right(tMovies),
    );
    // act
    final result = await usecase.execute();
    // assert
    expect(
      result,
      Right(tMovies),
    );
  });
}
