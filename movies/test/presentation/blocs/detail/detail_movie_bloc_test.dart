import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_detail_movie.dart';
import 'package:movies/domain/usecases/get_recommendation_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movie.dart';
import 'package:movies/domain/usecases/remove_watchlist_movie.dart';
import 'package:movies/domain/usecases/save_watchlist_movie.dart';
import 'package:movies/presentation/blocs/detail/detail_movie_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetDetailMovie,
  GetRecommendationMovies,
  GetWatchListStatusMovie,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetDetailMovie mockGetDetailMovie;
  late MockGetRecommendationMovies mockGetRecommendationMovies;
  late MockGetWatchListStatusMovie mockGetWatchListStatusMovie;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockGetDetailMovie = MockGetDetailMovie();
    mockGetRecommendationMovies = MockGetRecommendationMovies();
    mockGetWatchListStatusMovie = MockGetWatchListStatusMovie();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    detailMovieBloc = DetailMovieBloc(
      getDetailMovie: mockGetDetailMovie,
      getRecommendationMovies: mockGetRecommendationMovies,
      getWatchListStatusMovie: mockGetWatchListStatusMovie,
      saveWatchlistMovie: mockSaveWatchlistMovie,
      removeWatchlistMovie: mockRemoveWatchlistMovie,
    );
  });

  const tId = 1;

  group('Get Detail Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Emit Load Detail Movie Recomendation when get success',
      build: () {
        when(
          mockGetDetailMovie.execute(tId),
        ).thenAnswer(
          (_) async => const Right(testMovieDetail),
        );
        when(
          mockGetRecommendationMovies.execute(tId),
        ).thenAnswer(
          (_) async => Right(testMovieList),
        );
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        FetchDetailMovie(tId),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.loading,
        ),
        DetailMovieState.initial().copyWith(
          movieRecommendationsState: RequestState.loading,
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
        ),
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.loaded,
          movieRecommendations: testMovieList,
        ),
      ],
      verify: (_) {
        verify(
          mockGetDetailMovie.execute(tId),
        );
        verify(
          mockGetRecommendationMovies.execute(tId),
        );
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Emit Detail Movie Error when get detail movie failed',
      build: () {
        when(
          mockGetDetailMovie.execute(tId),
        ).thenAnswer(
          (_) async => const Left(
            ConnectionFailure('Failed'),
          ),
        );
        when(
          mockGetRecommendationMovies.execute(tId),
        ).thenAnswer(
          (_) async => Right(testMovieList),
        );
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        FetchDetailMovie(tId),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.loading,
        ),
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(
          mockGetDetailMovie.execute(tId),
        );
        verify(
          mockGetRecommendationMovies.execute(tId),
        );
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Emit Loading Detail Movie Recommendation Empty when get empty',
      build: () {
        when(
          mockGetDetailMovie.execute(tId),
        ).thenAnswer(
          (_) async => const Right(testMovieDetail),
        );
        when(
          mockGetRecommendationMovies.execute(tId),
        ).thenAnswer(
          (_) async => const Right([]),
        );
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        FetchDetailMovie(tId),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.loading,
        ),
        DetailMovieState.initial().copyWith(
          movieRecommendationsState: RequestState.loading,
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
        ),
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.empty,
        ),
      ],
      verify: (_) {
        verify(
          mockGetDetailMovie.execute(tId),
        );
        verify(
          mockGetRecommendationMovies.execute(tId),
        );
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Emit Loading of Detail Movie Recomendation when get failed',
      build: () {
        when(
          mockGetDetailMovie.execute(tId),
        ).thenAnswer(
          (_) async => const Right(testMovieDetail),
        );
        when(
          mockGetRecommendationMovies.execute(tId),
        ).thenAnswer(
          (_) async => const Left(
            ConnectionFailure('Failed'),
          ),
        );
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        FetchDetailMovie(tId),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.loading,
        ),
        DetailMovieState.initial().copyWith(
          movieRecommendationsState: RequestState.loading,
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
        ),
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(
          mockGetDetailMovie.execute(tId),
        );
        verify(
          mockGetRecommendationMovies.execute(tId),
        );
      },
    );
  });

  group('Load Watchlist Status Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Emit Watchlist Status is true',
      build: () {
        when(
          mockGetWatchListStatusMovie.execute(tId),
        ).thenAnswer((_) async => true);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        LoadWatchlistStatusMovie(tId),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(isAddedToWatchlist: true),
      ],
      verify: (_) => verify(
        mockGetWatchListStatusMovie.execute(tId),
      ),
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Emit Watchlist Status is false',
      build: () {
        when(
          mockGetWatchListStatusMovie.execute(tId),
        ).thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        LoadWatchlistStatusMovie(tId),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(isAddedToWatchlist: false),
      ],
      verify: (_) => verify(
        mockGetWatchListStatusMovie.execute(tId),
      ),
    );
  });

  group('Add to Movie Watchlist Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Emit isAddedToWatchlist when success Add to Movie Watchlist',
      build: () {
        when(
          mockSaveWatchlistMovie.execute(testMovieDetail),
        ).thenAnswer(
          (_) async => const Right('Add to Movie Watchlist'),
        );
        when(
          mockGetWatchListStatusMovie.execute(testMovieDetail.id),
        ).thenAnswer((_) async => true);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        AddWatchlistMovie(testMovieDetail),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(
          watchlistMessage: 'Add to Movie Watchlist',
        ),
        DetailMovieState.initial().copyWith(
          watchlistMessage: 'Add to Movie Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(
          mockSaveWatchlistMovie.execute(testMovieDetail),
        );
        verify(
          mockGetWatchListStatusMovie.execute(testMovieDetail.id),
        );
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Emit Watchlist Message when failed Add to Movie Watchlist',
      build: () {
        when(
          mockSaveWatchlistMovie.execute(testMovieDetail),
        ).thenAnswer(
          (_) async => const Left(
            DatabaseFailure('Failed'),
          ),
        );
        when(mockGetWatchListStatusMovie.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        AddWatchlistMovie(testMovieDetail),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(
          mockSaveWatchlistMovie.execute(testMovieDetail),
        );
        verify(
          mockGetWatchListStatusMovie.execute(testMovieDetail.id),
        );
      },
    );
  });

  group('Remove From Watchlist Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Emit isAddedToWatchlis when success Remove from Movie Watchlist',
      build: () {
        when(
          mockRemoveWatchlistMovie.execute(testMovieDetail),
        ).thenAnswer(
          (_) async => const Right('Remove from Movie Watchlist'),
        );
        when(
          mockGetWatchListStatusMovie.execute(testMovieDetail.id),
        ).thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        RemoveFromWatchlistMovie(testMovieDetail),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(
          watchlistMessage: 'Remove from Movie Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(
          mockRemoveWatchlistMovie.execute(testMovieDetail),
        );
        verify(
          mockGetWatchListStatusMovie.execute(testMovieDetail.id),
        );
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Emit WatchlistMessage when failed Remove from Movie Watchlist',
      build: () {
        when(
          mockRemoveWatchlistMovie.execute(testMovieDetail),
        ).thenAnswer(
          (_) async => const Left(
            DatabaseFailure('Failed'),
          ),
        );
        when(mockGetWatchListStatusMovie.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        RemoveFromWatchlistMovie(testMovieDetail),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(
          mockRemoveWatchlistMovie.execute(testMovieDetail),
        );
        verify(
          mockGetWatchListStatusMovie.execute(testMovieDetail.id),
        );
      },
    );
  });
}
