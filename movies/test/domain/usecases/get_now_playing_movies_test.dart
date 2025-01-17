import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetNowPlayingMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];

  test('GET now playing from the repository', () async {
    // arrange
    when(
      mockMovieRepository.getNowPlaying(),
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
