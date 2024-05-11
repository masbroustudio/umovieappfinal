import 'package:flutter_test/flutter_test.dart';
import 'package:umovieapp/data/models/genre_model.dart';

void main() {
  group('GenreModel', () {
    final int testId = 1;
    final String testName = "Action";
    final Map<String, dynamic> testJson = {
      "id": testId,
      "name": testName,
    };

    test('fromJson creates a GenreModel object', () {
      final genre = GenreModel.fromJson(testJson);

      expect(genre.id, testId);
      expect(genre.name, testName);
    });

    test('toJson converts the object to a JSON map', () {
      final genre = GenreModel(id: testId, name: testName);
      final json = genre.toJson();

      expect(json['id'], testId);
      expect(json['name'], testName);
    });

    test('toEntity converts to a Genre object', () {
      final genre = GenreModel(id: testId, name: testName);
      final genreEntity = genre.toEntity();

      expect(genreEntity.id, testId); // Assuming Genre has an 'id' field
      expect(genreEntity.name, testName); // Assuming Genre has a 'name' field
    });

    test('props returns a list with id and name', () {
      final genre = GenreModel(id: testId, name: testName);
      final props = genre.props;

      expect(props.length, 2);
      expect(props[0], testId);
      expect(props[1], testName);
    });
  });
}
