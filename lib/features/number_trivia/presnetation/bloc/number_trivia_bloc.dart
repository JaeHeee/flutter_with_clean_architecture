import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_with_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc(NumberTriviaState initialState) : super(initialState);
  // NumberTriviaBloc() : super(NumberTriviaInitial())
  //  {
  //   on<NumberTriviaEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }
}
