import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie({
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
  });

  const Movie.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    this.originalTitle,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.adult,
    this.backdropPath,
    this.genreIds,
  });

  final int id;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;

  @override
  List<Object?> get props => [
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
        adult,
        backdropPath,
        genreIds,
      ];
}
