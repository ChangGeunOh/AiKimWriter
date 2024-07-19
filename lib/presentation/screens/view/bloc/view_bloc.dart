import 'dart:async';

import 'package:bloc/src/bloc.dart';

import '../../../../domain/bloc/bloc_bloc.dart';
import '../../../../domain/bloc/bloc_event.dart';
import 'view_event.dart';
import 'view_state.dart';

class ViewBloc extends BlocBloc<BlocEvent<ViewEvent>, ViewState> {
  ViewBloc(super.context, super.initialState);

  @override
  FutureOr<void> onBlocEvent(
    BlocEvent<ViewEvent> event,
    Emitter<ViewState> emit,
  ) {
    switch(event.type) {
      case ViewEvent.init:
        break;
    }
  }
}
