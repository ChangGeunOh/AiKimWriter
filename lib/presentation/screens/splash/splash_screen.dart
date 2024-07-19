import 'package:aikimwriter/domain/bloc/bloc_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/mixin.dart';
import '../../../domain/bloc/bloc_scaffold.dart';
import 'bloc/splash_bloc.dart';
import 'bloc/splash_event.dart';
import 'bloc/splash_state.dart';
import 'widgets/permission_dialog.dart';

class SplashScreen extends StatelessWidget with ShowMessage {
  static String get routeName => "splash";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocScaffold<SplashBloc, SplashState>(
      create: (context) => SplashBloc(context, SplashState()),
      builder: (context, bloc, state) {
        // WidgetsBinding.instance.addPostFrameCallback(
        //   (timeStamp) async {
        //     print('showPermission: ${state.showPermission}');
        //     if (state.showPermission && !bloc.isDialogShowing) {
        //       bloc.isDialogShowing = true;
        //       await showDialog(
        //           context: context,
        //           builder: (context) {
        //             return const PermissionDialog();
        //           });
        //       bloc.isDialogShowing = false;
        //       bloc.add(BlocEvent(SplashEvent.nextScreen));
        //     }
        //   },
        // );
        return Stack(
          children: [
            Image.asset(
              'assets/images/img_poster.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 160),
                Image.asset('assets/images/img_bside.png'),
                const SizedBox(height: 16),
                const Text(
                  'AI 김작가',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '여행 사진으로 만드는 나만의 여행기록',
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return const PermissionDialog();
                          },
                        );
                        bloc.add(BlocEvent(SplashEvent.nextScreen));
                      },
                      child: const Text('나만의 여행기록 만들기'),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
