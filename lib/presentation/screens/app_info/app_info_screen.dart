import 'package:flutter/material.dart';

import '../../../domain/bloc/bloc_scaffold.dart';
import 'bloc/app_info_bloc.dart';
import 'bloc/app_info_state.dart';

class AppInfoScreen extends StatelessWidget {
  static String get routeName => 'app-info';

  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocScaffold<AppInfoBloc, AppInfoState>(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('App 정보'),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      create: (context) => AppInfoBloc(
        context,
        AppInfoState(),
      ),
      builder: (context, bloc, state) {
        return SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 125),
                Image.asset(
                  'assets/images/img_launcher.png',
                  width: 200,
                ),
                const SizedBox(height: 32),
                const Text(
                  "최신 버전을 사용하고 있습니다.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '현재 버전 : ${state.currentVersion}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                const Text(
                  '지원환경 Android OS 10, iPhone 12 이상',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
