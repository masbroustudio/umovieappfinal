import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

  test('init state should be empty', () {
    expect(
      nowPlayingMoviesBloc.state,
      NowPlayingMoviesEmpty(),
    );
  });

  final tMovieList = <Movie>[testMovie];

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Emit Loading has Data when data is success',
    build: () {
      when(
        mockGetNowPlayingMovies.execute(),
      ).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(
      FetchNowPlayingMovies(),
    ),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesHasData(tMovieList),
    ],
    verify: (bloc) => verify(
      mockGetNowPlayingMovies.execute(),
    ),
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Emit Loading Error when get now playing movies is failed',
    build: () {
      when(
        mockGetNowPlayingMovies.execute(),
      ).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(
      FetchNowPlayingMovies(),
    ),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesError('Server Failure'),
    ],
    verify: (bloc) => verify(
      mockGetNowPlayingMovies.execute(),
    ),
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Emit Loading Empty when data is empty',
    build: () {
      when(
        mockGetNowPlayingMovies.execute(),
      ).thenAnswer(
        (_) async => const Right([]),
      );
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(
      FetchNowPlayingMovies(),
    ),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesEmpty(),
    ],
    verify: (bloc) => verify(
      mockGetNowPlayingMovies.execute(),
    ),
  );
}
