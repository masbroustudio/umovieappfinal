import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? overview;
  final String? posterPath;

  const MovieTable({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        overview: map['overview'],
        posterPath: map['posterPath'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'overview': overview,
        'posterPath': posterPath,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
      ];
}
