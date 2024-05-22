import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<MovieTable?> getWatchlistById(int id);
  Future<List<MovieTable>> getWatchlist();
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;
  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<MovieTable?> getWatchlistById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlist() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlistMovie(movie);
      return 'Add to Movie Watchlist';
    } catch (e) {
      throw DatabaseException(
        e.toString(),
      );
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlistMovie(movie);
      return 'Remove from Movie Watchlist';
    } catch (e) {
      throw DatabaseException(
        e.toString(),
      );
    }
  }
}
