import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_with_clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import 'package:flutter_with_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  const testNumberTrivia = NumberTrivia(
    text: 'test',
    number: 1,
  );

  test(
    'should get trivia from the repository.',
    () async {
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const Right(testNumberTrivia));

      final result = await usecase(NoParams());

      expect(result, const Right(testNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
