import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;

  const TvSeriesTable({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvSeries) => TvSeriesTable(
        id: tvSeries.id,
        name: tvSeries.name,
        overview: tvSeries.overview,
        posterPath: tvSeries.posterPath,
      );

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
        id: map['id'],
        name: map['name'],
        overview: map['overview'],
        posterPath: map['posterPath'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'overview': overview,
        'posterPath': posterPath,
      };

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        name: name,
        posterPath: posterPath,
        overview: overview,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
      ];
}
