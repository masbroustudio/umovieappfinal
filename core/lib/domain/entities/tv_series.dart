import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  const TvSeries({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.popularity,
    required this.backdropPath,
    required this.voteAverage,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.originalName,
  });

  const TvSeries.watchlist({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    this.popularity,
    this.backdropPath,
    this.voteAverage,
    this.firstAirDate,
    this.originCountry,
    this.genreIds,
    this.originalLanguage,
    this.voteCount,
    this.originalName,
  });

  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final double? popularity;
  final String? backdropPath;
  final double? voteAverage;
  final String? firstAirDate;
  final List<String>? originCountry;
  final List<int>? genreIds;
  final String? originalLanguage;
  final int? voteCount;
  final String? originalName;

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        popularity,
        backdropPath,
        voteAverage,
        firstAirDate,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        originalName,
      ];
}
