import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../domain/bloc/bloc_scaffold.dart';
import 'bloc/open_source_bloc.dart';
import 'bloc/open_source_state.dart';

class OpenSourceScreen extends StatelessWidget {
  static String get routeName => "open_source";

  const OpenSourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocScaffold<OpenSourceBloc, OpenSourceState>(
      appBar: AppBar(
        title: const Text('오픈소스 라이센스'),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      create: (context) => OpenSourceBloc(
        context,
        OpenSourceState(),
      ),
      builder: (context, bloc, state) {
        if (state.controller == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return WebViewWidget(controller: state.controller!);
      },
    );
  }
}
