import 'package:equatable/equatable.dart';

class Season extends Equatable {
  const Season({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.airDate,
    required this.episodeCount,
  });

  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final String? airDate;
  final int episodeCount;

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        airDate,
        episodeCount,
      ];
}
