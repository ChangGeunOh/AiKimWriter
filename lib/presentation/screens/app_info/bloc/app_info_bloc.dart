import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../domain/bloc/bloc_bloc.dart';
import '../../../../domain/bloc/bloc_event.dart';
import 'app_info_event.dart';
import 'app_info_state.dart';


class AppInfoBloc extends BlocBloc<BlocEvent<AppInfoEvent>, AppInfoState> {
  AppInfoBloc(super.context, super.initialState) {
    init();
  }

  void init() {
    add(BlocEvent(AppInfoEvent.init));
  }

  @override
  FutureOr<void> onBlocEvent(
      BlocEvent<AppInfoEvent> event, Emitter<AppInfoState> emit) async {
    switch (event.type) {
      case AppInfoEvent.init:
        try {
          final packageInfo = await PackageInfo.fromPlatform();
          final currentVersion = packageInfo.version;
          emit(state.copyWith(currentVersion: currentVersion));
        } catch (e) {
          print('error: $e');
        }
        break;
    }
  }
}
