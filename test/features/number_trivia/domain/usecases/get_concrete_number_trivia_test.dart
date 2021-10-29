import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const testNumber = 1;
  const testNumberTrivia = NumberTrivia(
    text: 'test',
    number: testNumber,
  );

  test(
    'should get trivia for the number from the repository.',
    () async {
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(testNumberTrivia));

      final result = await usecase.execute(number: testNumber);

      expect(result, const Right(testNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(testNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
