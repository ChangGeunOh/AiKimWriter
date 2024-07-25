import 'dart:async';

import 'package:aikimwriter/presentation/screens/app_info/app_info_screen.dart';
import 'package:aikimwriter/presentation/screens/open_source/open_source_screen.dart';
import 'package:aikimwriter/presentation/screens/story/story_screen.dart';
import 'package:aikimwriter/presentation/screens/under/under_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../domain/bloc/bloc_bloc.dart';
import '../../../../domain/bloc/bloc_event.dart';
import '../../../../domain/model/main/story_data.dart';
import '../../view/view_screen.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends BlocBloc<BlocEvent<MainEvent>, MainState> {
  MainBloc(
    super.context,
    super.initialState,
  ) {
    add(BlocEvent(MainEvent.init));
  }

  @override
  FutureOr<void> onBlocEvent(
    BlocEvent<MainEvent> event,
    Emitter<MainState> emit,
  ) async {
    switch (event.type) {
      case MainEvent.init:
        final permission = await PhotoManager.requestPermissionExtend();
        _processPermission(permission);
        final list = await usesCases.storyCase.loadStoryDataList();
        emit(state.copyWith(
          storyDataList: list,
        ));
        break;
      case MainEvent.onAddStory:
        final result = await context.pushNamed(StoryScreen.routeName);
        if (result != null) {
          final storyData = result as StoryData;
          usesCases.storyCase.saveStoryData(storyData);
          final list = [...state.storyDataList, storyData];
          emit(state.copyWith(storyDataList: list));
        }
        break;
      case MainEvent.onPassword:
        context.pushNamed(UnderScreen.routeName);
        break;
      case MainEvent.onAuthMethod:
        context.pushNamed(UnderScreen.routeName);
        break;
      case MainEvent.onNotice:
        context.pushNamed(UnderScreen.routeName);
        break;
      case MainEvent.onOpenSource:
        print('Open Source');
        context.pushNamed(OpenSourceScreen.routeName);
        break;
      case MainEvent.onLogout:
        break;
      case MainEvent.onAppInfo:
        context.pushNamed(AppInfoScreen.routeName);
        break;
      case MainEvent.onTapStroy:
        final storyData = await context.pushNamed(
          ViewScreen.routeName,
          extra: event.extra as StoryData,
        );
        if (storyData != null) {
          await _removeStoryData(storyData as StoryData, emit);
        }
        break;
      case MainEvent.onRemove:
        final storyData = event.extra as StoryData;
        await _removeStoryData(storyData, emit);
        break;
    }
  }

  Future<void> _removeStoryData(
    StoryData storyData,
    Emitter<MainState> emit,
  ) async {
    print('remove: ${storyData.id}');
    print(storyData.toJson());
    await usesCases.storyCase.removeStoryData(storyData);
    final list = await usesCases.storyCase.loadStoryDataList();
    emit(state.copyWith(
      storyDataList: list,
    ));
  }

  void _processPermission(PermissionState permission) {
    switch (permission) {
      case PermissionState.authorized:
        break;
      case PermissionState.denied:
        break;
      case PermissionState.limited:
        break;
      case PermissionState.notDetermined:
        break;
      case PermissionState.restricted:
        break;
    }
  }
}
