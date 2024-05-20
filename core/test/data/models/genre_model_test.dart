import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  const tGenreJson = {
    'id': 1,
    'name': 'name',
  };

  const tGenre = Genre(
    id: 1,
    name: 'name',
  );

  test('To json should be a subclass of Genre', () {
    final result = tGenreModel.toJson();
    expect(result, tGenreJson);
  });

  test('To entity should be a subclass of Genre', () {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });
}
