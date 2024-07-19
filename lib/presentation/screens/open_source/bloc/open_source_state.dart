import 'package:webview_flutter/webview_flutter.dart';

import '../../../../domain/bloc/bloc_state.dart';

class OpenSourceState extends BlocState {
  final WebViewController? controller;
  OpenSourceState({
    super.message = '',
    super.isLoading = false,
    this.controller,
  });

  @override
  OpenSourceState copyWith({
    String? message,
    bool? isLoading,
    WebViewController? controller,
  }) {
    return OpenSourceState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      controller: controller ?? this.controller,
    );
  }
}
