import 'package:dartz/dartz.dart';
import 'package:umovieapp/common/failure.dart';
import 'package:umovieapp/domain/entities/movie_detail.dart';
import 'package:umovieapp/domain/repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
