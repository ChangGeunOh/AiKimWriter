import 'package:aikimwriter/presentation/screens/gallery/gallery_screen.dart';
import 'package:aikimwriter/presentation/screens/main/main_screen.dart';
import 'package:aikimwriter/presentation/screens/open_source/open_source_screen.dart';
import 'package:aikimwriter/presentation/screens/story/story_screen.dart';
import 'package:aikimwriter/presentation/screens/view/view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../domain/model/main/story_data.dart';
import '../../presentation/screens/app_info/app_info_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/under/under_screen.dart';

final routerConfig = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/main',
      name: MainScreen.routeName,
      builder: (_, __) => const MainScreen(),
    ),
    GoRoute(
      path: '/under',
      name: UnderScreen.routeName,
      builder: (_, __) => const UnderScreen(),
    ),
    GoRoute(
      path: '/open-source',
      name: OpenSourceScreen.routeName,
      builder: (_, __) => const OpenSourceScreen(),
    ),
    GoRoute(
      path: '/app-info',
      name: AppInfoScreen.routeName,
      builder: (_, __) => const AppInfoScreen(),
    ),
    GoRoute(
      path: '/story',
      name: StoryScreen.routeName,
      builder: (_, __) => const StoryScreen(),
    ),
    GoRoute(
      path: '/view',
      name: ViewScreen.routeName,
      builder: (context, state) {
        final storyData = state.extra as StoryData;
        return ViewScreen(
          storyData: storyData,
        );
      },
    ),
    GoRoute(
      path: '/gallery',
      name: GalleryScreen.routeName,
      pageBuilder: (_, __) => CustomTransitionPage(
        child: const GalleryScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    ),
  ],
);
