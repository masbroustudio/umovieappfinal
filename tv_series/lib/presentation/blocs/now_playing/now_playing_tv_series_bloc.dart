import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries _getNowPlayingTvSeries;

  NowPlayingTvSeriesBloc(this._getNowPlayingTvSeries)
      : super(
          NowPlayingTvSeriesEmpty(),
        ) {
    on<FetchNowPlayingTvSeries>((event, emit) async {
      emit(
        NowPlayingTvSeriesLoading(),
      );

      final result = await _getNowPlayingTvSeries.execute();

      result.fold(
        (failure) => emit(
          NowPlayingTvSeriesError(failure.message),
        ),
        (data) => emit(
          NowPlayingTvSeriesHasData(data),
        ),
      );
    });
  }
}
