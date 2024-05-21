import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_season_detail.dart';
import 'package:tv_series/presentation/blocs/season_detail/season_detail_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'season_detail_bloc_test.mocks.dart';

@GenerateMocks([GetSeasonDetail])
void main() {
  late SeasonDetailBloc seasonDetailBloc;
  late MockGetSeasonDetail mockGetSeasonDetail;

  setUp(() {
    mockGetSeasonDetail = MockGetSeasonDetail();
    seasonDetailBloc = SeasonDetailBloc(mockGetSeasonDetail);
  });

  const tId = 1;
  const tSeasonNumber = 1;

  test('init state Season Detail Tv Series should be empty', () {
    expect(
      seasonDetailBloc.state,
      SeasonDetailEmpty(),
    );
  });

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'Emit Loading has Data when data is success',
    build: () {
      when(
        mockGetSeasonDetail.execute(tId, tSeasonNumber),
      ).thenAnswer(
        (_) async => const Right(tSeasonDetail),
      );
      return seasonDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchSeasonDetail(
      id: tId,
      seasonNumber: tSeasonNumber,
    )),
    expect: () => [
      SeasonDetailLoading(),
      const SeasonDetailHasData(tSeasonDetail),
    ],
    verify: (bloc) => verify(
      mockGetSeasonDetail.execute(tId, tSeasonNumber),
    ),
  );

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'Emit Loading Error when get detail season is failed',
    build: () {
      when(
        mockGetSeasonDetail.execute(tId, tSeasonNumber),
      ).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );
      return seasonDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchSeasonDetail(
      id: tId,
      seasonNumber: tSeasonNumber,
    )),
    expect: () => [
      SeasonDetailLoading(),
      const SeasonDetailError('Server Failure'),
    ],
    verify: (bloc) => verify(
      mockGetSeasonDetail.execute(tId, tSeasonNumber),
    ),
  );
}
