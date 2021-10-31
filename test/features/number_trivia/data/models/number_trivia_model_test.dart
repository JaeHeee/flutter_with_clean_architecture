import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testNumberTriviaModel = NumberTriviaModel(
    number: 1,
    text: 'Test text.',
  );

  test('should be a subclass of NumberTrivia entity.', () async {
    expect(testNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('shoud return a valid model when the JSON number is an integer.',
        () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, testNumberTriviaModel);
    });

    test(
        'shoud return a valid model when the JSON number is regarded as a double.',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, testNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data.', () async {
      final result = testNumberTriviaModel.toJson();
      final expectedMap = {
        "text": "Test text.",
        "number": 1,
      };

      expect(result, expectedMap);
    });
  });
}
