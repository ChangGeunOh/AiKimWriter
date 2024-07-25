import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../usecase/story_case.dart';
import '../usecase/use_cases.dart';
import 'bloc_state.dart';

abstract class BlocBloc<Event, State extends BlocState>
    extends Bloc<Event, State> {
  final BuildContext context;
  final UseCases usesCases;

  BlocBloc(this.context, State initialState)
      : usesCases = context.read(),
        super(initialState) {
    on<Event>(onBlocEvent);
  }

  FutureOr<void> onBlocEvent(
    Event event,
    Emitter<State> emit,
  );
}
