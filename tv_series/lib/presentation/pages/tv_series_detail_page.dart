import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/presentation/blocs/detail/detail_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/recommendation/recommendation_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/watchlist_status/watchlist_status_tv_series_bloc.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final int id;
  const TvSeriesDetailPage({super.key, required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final id = widget.id;
      context.read<DetailTvSeriesBloc>().add(
            FetchDetailTvSeries(id),
          );
      context.read<WatchlistStatusTvSeriesBloc>().add(
            LoadWatchlistStatusTvSeries(id),
          );
      context.read<RecommendationTvSeriesBloc>().add(
            FetchRecommendationTvSeries(id),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
        builder: (_, state) {
          if (state is DetailTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTvSeriesHasData) {
            return SafeArea(
              child: DetailContent(state.result),
            );
          } else if (state is DetailTvSeriesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeriesDetail;
  const DetailContent(this.tvSeriesDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageUrl${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchlistStatusTvSeriesBloc,
                                WatchlistStatusTvSeriesState>(
                              listener: (context, state) {
                                if (state.message ==
                                        WatchlistStatusTvSeriesBloc
                                            .watchlistAddSuccessMessage ||
                                    state.message ==
                                        WatchlistStatusTvSeriesBloc
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(state.message),
                                      );
                                    },
                                  );
                                }
                              },
                              listenWhen: (oldState, newState) =>
                                  oldState.message != newState.message &&
                                  newState.message != '',
                              builder: (context, state) {
                                return ElevatedButton(
                                  key: const Key('watchlistButton'),
                                  onPressed: () async {
                                    if (!state.isAddedToWatchlist) {
                                      context
                                          .read<WatchlistStatusTvSeriesBloc>()
                                          .add(
                                            AddWatchlistTvSeries(
                                              tvSeriesDetail,
                                            ),
                                          );
                                    } else {
                                      context
                                          .read<WatchlistStatusTvSeriesBloc>()
                                          .add(
                                            RemoveFromWatchlistTvSeries(
                                              tvSeriesDetail,
                                            ),
                                          );
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      state.isAddedToWatchlist
                                          ? const Icon(Icons.check)
                                          : const Icon(Icons.add),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(tvSeriesDetail.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            TvSeriesSeasonList(
                              tvId: tvSeriesDetail.id,
                              seasons: tvSeriesDetail.seasons,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvSeriesBloc,
                                RecommendationTvSeriesState>(
                              builder: (_, state) {
                                if (state is RecommendationTvSeriesLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationTvSeriesHasData) {
                                  return TvSeriesRecommendationList(
                                    tvSeriesList: state.result,
                                  );
                                } else if (state
                                    is RecommendationTvSeriesError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey[800],
                                    ),
                                    height: 150,
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.tv_off),
                                          SizedBox(height: 2),
                                          Text('No Recommendations'),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 4,
                        width: 48,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            foregroundColor: Colors.white,
            backgroundColor: kRichBlack,
            child: IconButton(
              key: const Key('iconBack'),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    return genres.map((genre) => genre.name).join(', ');
  }
}

class TvSeriesRecommendationList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;
  const TvSeriesRecommendationList({required this.tvSeriesList, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () => Navigator.pushReplacementNamed(
                context,
                tvSeriesDetailRoute,
                arguments: tvSeries.id,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvSeries.posterPath}',
                  placeholder: (_, __) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (_, __, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}

class TvSeriesSeasonList extends StatelessWidget {
  final int tvId;
  final List<Season> seasons;

  const TvSeriesSeasonList({
    required this.tvId,
    required this.seasons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final season = seasons[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                seasonDetailRoute,
                arguments: {
                  'id': tvId,
                  'seasonNumber': season.seasonNumber,
                },
              ),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[800],
                ),
                child: Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: season.posterPath != null
                              ? '$baseImageUrl${season.posterPath}'
                              : 'https://i.ibb.co/TWLKGMY/No-Image-Available.jpg',
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder: (_, __) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorWidget: (_, __, error) {
                            return Container(
                              color: Colors.black26,
                              child: const Center(
                                child: Text('No Image'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Center(
                          child: Text(
                            season.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: seasons.length,
      ),
    );
  }
}
