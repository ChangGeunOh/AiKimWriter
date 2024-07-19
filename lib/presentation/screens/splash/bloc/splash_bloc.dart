import 'dart:async';

import 'package:aikimwriter/presentation/screens/main/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/bloc/bloc_bloc.dart';
import '../../../../domain/bloc/bloc_event.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends BlocBloc<BlocEvent<SplashEvent>, SplashState> {
  SplashBloc(super.context, super.initialState) {
    add(BlocEvent(SplashEvent.init));
  }

  bool isDialogShowing = false;


  @override
  Future<FutureOr<void>> onBlocEvent(
      BlocEvent<SplashEvent> event, Emitter<SplashState> emit) async {
    switch (event.type) {
      case SplashEvent.init:
        // final showPermission = await usesCases.splashCase.getShowPermission();
        // if (showPermission) {
        //   add(BlocEvent(SplashEvent.nextScreen));
        // }
        // emit(state.copyWith(showPermission: !showPermission));
        break;
      case SplashEvent.nextScreen:
        usesCases.splashCase.setShowPermission(true);
        Timer(const Duration(milliseconds: 200), () {
          context.goNamed(MainScreen.routeName);
        });
       break;
    }
  }
}
