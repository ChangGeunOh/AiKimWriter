import 'package:aikimwriter/presentation/screens/story/page/stroy_page_02.dart';
import 'package:aikimwriter/presentation/screens/story/page/stroy_page_04.dart';
import 'package:aikimwriter/presentation/screens/story/page/stroy_page_05.dart';
import 'package:aikimwriter/presentation/screens/story/page/stroy_page_06.dart';
import 'package:aikimwriter/presentation/screens/story/page/stroy_page_07.dart';
import 'package:aikimwriter/presentation/screens/story/widget/story_indicator.dart';
import 'package:aikimwriter/presentation/screens/story/page/story_page_01.dart';
import 'package:flutter/material.dart';

import '../../../common/const/const.dart';
import '../../../domain/bloc/bloc_event.dart';
import '../../../domain/bloc/bloc_scaffold.dart';
import 'bloc/story_bloc.dart';
import 'bloc/story_event.dart';
import 'bloc/story_state.dart';
import 'page/stroy_page_03.dart';
import 'widget/story_title.dart';

class StoryScreen extends StatelessWidget {
  static String get routeName => "story";

  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocScaffold<StoryBloc, StoryState>(
        backgroundColor: Colors.white,
        create: (context) => StoryBloc(context, StoryState()),
        appBarBuilder: (context, bloc, state) {
          return AppBar(
            centerTitle: true,
            title: const Text('이야기 만들기'),
            iconTheme: const IconThemeData(
              color: Colors.black54,
            ),
          );
        },
        builder: (context, bloc, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                child: StoryIndicator(
                    doneStepList: state.doneStepList,
                    step: state.step,
                    onTapStep: (step) {
                      bloc.add(BlocEvent(StoryEvent.onTapStep, extra: step));
                    }),
              ),
              Expanded(
                child: PageView(
                  controller: bloc.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    StoryPage01(
                      storyLabelData: storyLabelDataList[0],
                      onTravelType: (travelType) {
                        bloc.add(BlocEvent(StoryEvent.onTravelType,
                            extra: travelType));
                      },
                    ),
                    StoryPage02(
                      storyLabelData: storyLabelDataList[1],
                      onImageList: (imageList) {
                        bloc.add(BlocEvent(StoryEvent.onImageList,
                            extra: imageList));
                      },
                      imageList: state.imageDataList,
                    ),
                    StoryPage03(
                      step3data: state.step3Data,
                      imageDataList: state.imageDataList,
                      storyLabelData: storyLabelDataList[2],
                      onChanged: (step3data) {
                        bloc.add(BlocEvent(StoryEvent.onStep3Data,
                            extra: step3data));
                      },
                    ),
                    StoryPage04(
                      step4data: state.step4Data,
                      storyLabelData: storyLabelDataList[3],
                      onChanged: (step4data) {
                        bloc.add(BlocEvent(StoryEvent.onStep4Data,
                            extra: step4data));
                      },
                    ),
                    StoryPage05(
                      step5data: state.step5Data,
                      storyLabelData: storyLabelDataList[4],
                      onChanged: (step5data) {
                        bloc.add(BlocEvent(StoryEvent.onStep5Data,
                            extra: step5data));
                      },
                    ),
                    StoryPage06(
                      step6data: state.step6Data,
                      storyLabelData: storyLabelDataList[5],
                      onChanged: (step6data) {
                        bloc.add(BlocEvent(StoryEvent.onStep6Data,
                            extra: step6data));
                      },
                    ),
                    StoryPage07(
                      state: state,
                      step7data: state.step7Data,
                      storyLabelData: storyLabelDataList[6],
                      onChanged: (travelType) {
                        bloc.add(BlocEvent(StoryEvent.onStep7Data,
                            extra: travelType));
                      },
                      onTapDone: () {
                        bloc.add(BlocEvent(StoryEvent.onDone));
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

// Column(
//                   children: [
//                     StoryTitle(
//                       iconPath: storyLabelData.iconPath,
//                       description: storyLabelData.description,
//                     ),
//                   ],
//                 ),
