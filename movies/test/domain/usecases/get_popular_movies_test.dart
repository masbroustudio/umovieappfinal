import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularMovies usecase;
  late MockMovieRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMovieRepository();
    usecase = GetPopularMovies(mockMovieRpository);
  });

  final tMovies = <Movie>[];

  group('Popular Movies Tests', () {
    group('execute', () {
      test('GET list movies from repository when execute function is called',
          () async {
        // arrange
        when(
          mockMovieRpository.getPopular(),
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
    });
  });
}
