import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  const MovieDetail({
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
    required this.backdropPath,
    required this.genres,
  });

  final int id;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;
  final int voteCount;
  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;

  @override
  List<Object?> get props => [
        id,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        title,
        voteAverage,
        voteCount,
        adult,
        backdropPath,
        genres,
      ];
}
