import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../domain/bloc/bloc_bloc.dart';
import '../../../../domain/bloc/bloc_event.dart';
import 'open_source_event.dart';
import 'open_source_state.dart';

class OpenSourceBloc
    extends BlocBloc<BlocEvent<OpenSourceEvent>, OpenSourceState> {
  OpenSourceBloc(super.context, super.initialState) {
    init();
  }

  void init() {
    add(BlocEvent(OpenSourceEvent.onInit));
  }

  @override
  FutureOr<void> onBlocEvent(
    BlocEvent<OpenSourceEvent> event,
    Emitter<OpenSourceState> emit,
  ) async {
    switch (event.type) {
      case OpenSourceEvent.onInit:
        final WebViewController controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted);
        String fileText = await rootBundle.loadString('assets/files/open_source_license.htm');
        controller.loadHtmlString(fileText, baseUrl: 'https://paran.pe.kr');
        emit(state.copyWith(controller: controller));
        break;
    }
  }

}
