import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/remove_watchlist_movie.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistMovie usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchlistMovie(mockMovieRepository);
  });

  test('Remove watchlist movie from repository', () async {
    // arrange
    when(
      mockMovieRepository.removeWatchlist(testMovieDetail),
    ).thenAnswer(
      (_) async => const Right('Remove from Movie Watchlist'),
    );
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(
      mockMovieRepository.removeWatchlist(testMovieDetail),
    );
    expect(
      result,
      const Right('Remove from Movie Watchlist'),
    );
  });
}
