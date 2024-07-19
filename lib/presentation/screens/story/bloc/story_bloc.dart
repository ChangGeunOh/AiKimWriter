import 'dart:async';

import 'package:aikimwriter/domain/model/main/story_data.dart';
import 'package:aikimwriter/domain/model/story/step_3_data.dart';
import 'package:aikimwriter/domain/model/story/step_4_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/bloc/bloc_bloc.dart';
import '../../../../domain/bloc/bloc_event.dart';
import '../../../../domain/model/gallery/image_data.dart';
import '../../../../domain/model/story/step_5_data.dart';
import '../../../../domain/model/story/step_6_data.dart';
import '../../../../domain/model/story/step_7_data.dart';
import '../../gallery/gallery_screen.dart';
import 'story_event.dart';
import 'story_state.dart';

class StoryBloc extends BlocBloc<BlocEvent<StoryEvent>, StoryState> {
  late PageController pageController;

  StoryBloc(
    super.context,
    super.initialState,
  ) {
    pageController = PageController();
    add(BlocEvent(StoryEvent.init));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  @override
  Future<void> onBlocEvent(
    BlocEvent<StoryEvent> event,
    Emitter<StoryState> emit,
  ) async {
    switch (event.type) {
      case StoryEvent.init:
        break;
      case StoryEvent.onTapGallery:
        final result = await context.pushNamed(GalleryScreen.routeName);
        if (result != null) {
          emit(state.copyWith(
            imageDataList: result as List<ImageData>,
          ));
        }
        break;
      case StoryEvent.onTapStep:
        final step = event.extra as int;
        pageController.animateToPage(
          step - 1,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.easeInOut,
        );
        emit(state.copyWith(
          step: step,
        ));
        break;
      case StoryEvent.onTravelType:
        emit(state.copyWith(
          travelType: event.extra as String,
          step: 2,
        ));
        goToPage(1);
        break;
      case StoryEvent.onImageList:
        emit(state.copyWith(
          imageDataList: event.extra as List<ImageData>,
          step: 3,
        ));
        goToPage(2);
      case StoryEvent.onStep3Data:
        emit(state.copyWith(
          step3Data: event.extra as Step3Data,
          step: 4,
        ));
        goToPage(3);
      case StoryEvent.onStep4Data:
        emit(state.copyWith(
          step4Data: event.extra as Step4Data,
          step: 5,
        ));
        goToPage(4);
        break;
      case StoryEvent.onStep5Data:
        emit(state.copyWith(
          step5Data: event.extra as Step5Data,
          step: 6,
        ));
        goToPage(5);
        break;
      case StoryEvent.onStep6Data:
        emit(state.copyWith(
          step6Data: event.extra as Step6Data,
          step: 7,
        ));
        goToPage(6);
        break;
      case StoryEvent.onStep7Data:
        emit(state.copyWith(
          step7Data: event.extra as Step7Data,
          step: 8,
        ));
        goToPage(6);
      case StoryEvent.onDone:
        final storyData = StoryData(
          travelType: state.travelType,
          travelPlace: state.step3Data.location,
          travelDate: state.step3Data.dateTimeRange ?? DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now(),
          ),
          travelReview: state.step3Data.memo,
          imageDataList: state.imageDataList,
          coverImage: state.step3Data.imageData!,
          titleList: state.step4Data.titleList,
          bookTitle: state.step4Data.title,
          bookAuthor: '',
          bookGenre: state.step4Data.bookType!.type,
          bookStyle: state.step4Data.textStyle,
          aiStory: state.step5Data.aiStory,
          story: state.step5Data.story,
          coverStyle: state.step6Data.coverImage,
          innerStyle: state.step6Data.innerImage,
          bookPageList: state.step7Data.pageList,
        );
        context.pop(storyData);
        break;
    }
  }

  void goToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
