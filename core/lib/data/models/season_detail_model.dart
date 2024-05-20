import 'package:core/data/models/episode_model.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailResponse extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String? airDate;
  final List<EpisodeModel> episodes;
  final int seasonNumber;

  const SeasonDetailResponse({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.airDate,
    required this.episodes,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        airDate,
        episodes,
        seasonNumber,
      ];

  SeasonDetail toEntity() {
    return SeasonDetail(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      airDate: airDate,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
      seasonNumber: seasonNumber,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'overview': overview,
        'poster_path': posterPath,
        'air_date': airDate,
        'episodes': episodes.map((x) => x.toJson()).toList(),
        'season_number': seasonNumber,
      };

  factory SeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      SeasonDetailResponse(
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        airDate: json['air_date'],
        episodes: List<EpisodeModel>.from(
          json['episodes'].map(
            (x) => EpisodeModel.fromJson(x),
          ),
        ),
        seasonNumber: json['season_number'],
      );
}
