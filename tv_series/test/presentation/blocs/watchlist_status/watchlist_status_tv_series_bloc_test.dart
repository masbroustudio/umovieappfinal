import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:tv_series/presentation/blocs/watchlist_status/watchlist_status_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_status_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late WatchlistStatusTvSeriesBloc watchlistStatusTvSeriesBloc;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    watchlistStatusTvSeriesBloc = WatchlistStatusTvSeriesBloc(
      getWatchListStatusTvSeries: mockGetWatchListStatusTvSeries,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
    );
  });

  const tId = 1;

  group('Status Watchlist TV Series', () {
    blocTest<WatchlistStatusTvSeriesBloc, WatchlistStatusTvSeriesState>(
      'Emit Watchlist Status Tv Series state when get true',
      build: () {
        when(
          mockGetWatchListStatusTvSeries.execute(tId),
        ).thenAnswer((_) async => true);
        return watchlistStatusTvSeriesBloc;
      },
      act: (bloc) => bloc.add(
        const LoadWatchlistStatusTvSeries(tId),
      ),
      expect: () => [
        const WatchlistStatusTvSeriesState(
            isAddedToWatchlist: true, message: ''),
      ],
    );
  });

  group('Save Watchlist TV Series', () {
    blocTest<WatchlistStatusTvSeriesBloc, WatchlistStatusTvSeriesState>(
      'Emit Watchlist Status Tv Series state when data is saved',
      build: () {
        when(
          mockSaveWatchlistTvSeries.execute(tTvSeriesDetail),
        ).thenAnswer(
          (_) async => const Right('Add to Movie Watchlist'),
        );
        when(
          mockGetWatchListStatusTvSeries.execute(tId),
        ).thenAnswer((_) async => true);
        return watchlistStatusTvSeriesBloc;
      },
      act: (bloc) => bloc.add(
        const AddWatchlistTvSeries(tTvSeriesDetail),
      ),
      expect: () => [
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: true,
          message: 'Add to Movie Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(
          mockSaveWatchlistTvSeries.execute(tTvSeriesDetail),
        ),
        verify(
          mockGetWatchListStatusTvSeries.execute(tId),
        ),
      ],
    );

    blocTest<WatchlistStatusTvSeriesBloc, WatchlistStatusTvSeriesState>(
      'Emit Watchlist Status Tv Series state when save data is failed',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail)).thenAnswer(
          (_) async => const Left(
            DatabaseFailure('Failed Add to Movie Watchlist'),
          ),
        );
        when(
          mockGetWatchListStatusTvSeries.execute(tId),
        ).thenAnswer((_) async => false);
        return watchlistStatusTvSeriesBloc;
      },
      act: (bloc) => bloc.add(
        const AddWatchlistTvSeries(tTvSeriesDetail),
      ),
      expect: () => [
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: false,
          message: 'Failed Add to Movie Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(
          mockSaveWatchlistTvSeries.execute(tTvSeriesDetail),
        ),
        verify(
          mockGetWatchListStatusTvSeries.execute(tId),
        ),
      ],
    );
  });

  group('Remove Watchlist TV Series', () {
    blocTest<WatchlistStatusTvSeriesBloc, WatchlistStatusTvSeriesState>(
      'Emit Watchlist Status Tv Series state when data is removed',
      build: () {
        when(
          mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail),
        ).thenAnswer(
          (_) async => const Right('Remove from Movie Watchlist'),
        );
        when(
          mockGetWatchListStatusTvSeries.execute(tId),
        ).thenAnswer((_) async => false);
        return watchlistStatusTvSeriesBloc;
      },
      act: (bloc) => bloc.add(
        const RemoveFromWatchlistTvSeries(tTvSeriesDetail),
      ),
      expect: () => [
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: false,
          message: 'Remove from Movie Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(
          mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail),
        ),
        verify(
          mockGetWatchListStatusTvSeries.execute(tId),
        ),
      ],
    );

    blocTest<WatchlistStatusTvSeriesBloc, WatchlistStatusTvSeriesState>(
      'Emit Watchlist Status Tv Series state when remove data is failed',
      build: () {
        when(
          mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail),
        ).thenAnswer(
          (_) async => const Left(
            DatabaseFailure('Failed Remove from Movie Watchlist'),
          ),
        );
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistStatusTvSeriesBloc;
      },
      act: (bloc) => bloc.add(
        const RemoveFromWatchlistTvSeries(tTvSeriesDetail),
      ),
      expect: () => [
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: true,
          message: 'Failed Remove from Movie Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(
          mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail),
        ),
        verify(
          mockGetWatchListStatusTvSeries.execute(tId),
        ),
      ],
    );
  });
}
