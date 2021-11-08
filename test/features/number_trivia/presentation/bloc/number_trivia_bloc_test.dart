import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_with_clean_architecture/core/error/failures.dart';
import 'package:flutter_with_clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_with_clean_architecture/core/util/input_converter.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/presnetation/bloc/number_trivia_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia])
@GenerateMocks([GetRandomNumberTrivia])
@GenerateMocks([InputConverter])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    const testNumberString = '1';
    const testNumberParsed = 1;
    const testNumberTrivia = NumberTrivia(text: 'Test trivia', number: 1);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(testNumberParsed));

    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async* {
      setUpMockInputConverterSuccess();

      bloc.add(const GetTriviaForConcreteNumber(testNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      verify(mockInputConverter.stringToUnsignedInteger(testNumberString));
    });

    test('should emit [Error] when the input is invalid', () async* {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      final expected = [
        Empty(),
        const Error(message: invalidInputFailureMessage),
      ];
      expectLater(bloc, emitsInOrder(expected));

      bloc.add(const GetTriviaForConcreteNumber(testNumberString));
    });

    test('should get data from the concrete use case', () async* {
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(testNumberTrivia));

      bloc.add(const GetTriviaForConcreteNumber(testNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));

      verify(
          mockGetConcreteNumberTrivia(const Params(number: testNumberParsed)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async* {
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(testNumberTrivia));

      final expected = [
        Empty(),
        Loading(),
        const Loaded(trivia: testNumberTrivia),
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.add(const GetTriviaForConcreteNumber(testNumberString));
    });

    test('should emit [Loading, Error] when data is gotten fails', () async* {
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        Empty(),
        Loading(),
        const Error(message: serverFailureMessage),
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.add(const GetTriviaForConcreteNumber(testNumberString));
    });

    test(
        'should emit [Loading, Error] with a proper message for the error when getting data fails',
        () async* {
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        Empty(),
        Loading(),
        const Error(message: cacheFailureMessage),
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.add(const GetTriviaForConcreteNumber(testNumberString));
    });
  });

  group('GetTriviaForRandomNumber', () {
    const testNumberTrivia = NumberTrivia(text: 'Test trivia', number: 1);

    test('should get data from the random use case', () async* {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => const Right(testNumberTrivia));

      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));

      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async* {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => const Right(testNumberTrivia));

      final expected = [
        Empty(),
        Loading(),
        const Loaded(trivia: testNumberTrivia),
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.add(GetTriviaForRandomNumber());
    });

    test('should emit [Loading, Error] when data is gotten fails', () async* {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        Empty(),
        Loading(),
        const Error(message: serverFailureMessage),
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.add(GetTriviaForRandomNumber());
    });

    test(
        'should emit [Loading, Error] with a proper message for the error when getting data fails',
        () async* {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        Empty(),
        Loading(),
        const Error(message: cacheFailureMessage),
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.add(GetTriviaForRandomNumber());
    });
  });
}
