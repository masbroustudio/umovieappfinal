import 'package:core/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  const SeasonModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.airDate,
    required this.episodeCount,
    required this.seasonNumber,
  });

  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String? airDate;
  final int episodeCount;
  final int seasonNumber;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        airDate: json["air_date"],
        episodeCount: json["episode_count"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "air_date": airDate,
        "episode_count": episodeCount,
        "season_number": seasonNumber,
      };

  Season toEntity() {
    return Season(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      airDate: airDate,
      episodeCount: episodeCount,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        airDate,
        episodeCount,
        seasonNumber,
      ];
}
