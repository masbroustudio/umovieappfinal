import 'package:dartz/dartz.dart';
import 'package:umovieapp/domain/entities/movie.dart';
import 'package:umovieapp/domain/repositories/movie_repository.dart';
import 'package:umovieapp/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
