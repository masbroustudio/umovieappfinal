import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_recommendation_movies.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetRecommendationMovies(mockMovieRepository);
  });

  const tId = 1;
  final tMovies = <Movie>[];

  test('GET list movie recommendations from the repository', () async {
    // arrange
    when(
      mockMovieRepository.getRecommendation(tId),
    ).thenAnswer(
      (_) async => Right(tMovies),
    );
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(
      result,
      Right(tMovies),
    );
  });
}
