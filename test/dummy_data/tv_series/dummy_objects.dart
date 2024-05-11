import 'package:umovieapp/data/models/genre_model.dart';
import 'package:umovieapp/data/models/season_model.dart';
import 'package:umovieapp/data/models/tv_series_detail_model.dart';
import 'package:umovieapp/data/models/tv_series_model.dart';
import 'package:umovieapp/data/models/tv_series_table.dart';
import 'package:umovieapp/domain/entities/genre.dart';
import 'package:umovieapp/domain/entities/season.dart';
import 'package:umovieapp/domain/entities/tv_series.dart';
import 'package:umovieapp/domain/entities/tv_series_detail.dart';

final tTvSeriesModel = TvSeriesModel(
  posterPath: '/xiECPWEyydPiB7XJtciAiS2spKN.jpg',
  popularity: 1038.723,
  id: 1242,
  backdropPath: '/ijfWr8enbRzohBzQIhrv3jy5mI8.jpg',
  voteAverage: 6.652,
  overview:
      'Casey Cartwright is poised to become the most powerful girl in the Greek system. Rusty, her little brother, is new on campus and he\'s the geek. But he sees Cyprus-Rhodes University as an opportunity to create a whole new identity.',
  firstAirDate: '2007-07-09',
  originCountry: ['US'],
  genreIds: [35, 18],
  originalLanguage: 'en',
  voteCount: 105,
  name: 'Greek',
  originalName: 'Greek',
);

final tTvSeries = TvSeries(
  posterPath: '/xiECPWEyydPiB7XJtciAiS2spKN.jpg',
  popularity: 1038.723,
  id: 1242,
  backdropPath: '/ijfWr8enbRzohBzQIhrv3jy5mI8.jpg',
  voteAverage: 6.652,
  overview:
      'Casey Cartwright is poised to become the most powerful girl in the Greek system. Rusty, her little brother, is new on campus and he\'s the geek. But he sees Cyprus-Rhodes University as an opportunity to create a whole new identity.',
  firstAirDate: '2007-07-09',
  originCountry: ['US'],
  genreIds: [35, 18],
  originalLanguage: 'en',
  voteCount: 105,
  name: 'Greek',
  originalName: 'Greek',
);

final tTvSeriesResponse = TvSeriesDetailResponse(
  backdropPath: 'backdropPath',
  firstAirDate: '2022-10-10',
  genres: [GenreModel(id: 1, name: 'Drama')],
  homepage: 'https://google.com',
  id: 1,
  inProduction: false,
  languages: ['en'],
  lastAirDate: '2022-10-10',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 6,
  originCountry: ['US'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 369.0,
  posterPath: 'posterPath',
  seasons: [
    SeasonModel(
      airDate: '2022-10-10',
      episodeCount: 15,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 10,
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 8.3,
  voteCount: 1200,
);

final tTvSeriesDetail = TvSeriesDetail(
  backdropPath: 'backdropPath',
  firstAirDate: '2022-10-10',
  genres: [Genre(id: 1, name: 'Drama')],
  id: 1,
  lastAirDate: '2022-10-10',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 6,
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [
    Season(
      airDate: '2022-10-10',
      episodeCount: 15,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 10,
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 8.3,
  voteCount: 1200,
);

final tTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final tTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final tWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);
