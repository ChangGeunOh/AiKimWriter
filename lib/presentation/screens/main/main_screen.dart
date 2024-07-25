import 'dart:io';

import 'package:aikimwriter/presentation/screens/main/widget/story_grid_add_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/const/color.dart';
import '../../../domain/bloc/bloc_event.dart';
import '../../../domain/bloc/bloc_scaffold.dart';
import '../../../domain/model/main/story_data.dart';
import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';
import 'bloc/main_state.dart';
import 'widget/story_dialog.dart';
import 'widget/main_drawer.dart';

class MainScreen extends StatelessWidget {
  static String get routeName => "main";

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocScaffold<MainBloc, MainState>(
      create: (context) => MainBloc(context, MainState()),
      drawerBuilder: (context, bloc, state) {
        return MainDrawer(
          onTap: (event) {
            bloc.add(BlocEvent(event));
          },
        );
      },
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'AI 김작가',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      // floatingBuilder: (context, bloc, state) {
      //   return FloatingActionButton(
      //     backgroundColor: Colors.red,
      //     onPressed: () {
      //       bloc.add(BlocEvent(MainEvent.onAddStory));
      //     },
      //     child: const Icon(
      //       Icons.note_alt_outlined,
      //       color: Colors.white,
      //     ),
      //   );
      // },
      builder: (context, bloc, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 8,
                childAspectRatio: 0.76),
            itemBuilder: (context, index) {
              return StoryGridAddItem(
                imagePath: index == 0
                    ? ''
                    : state.storyDataList[index - 1].coverImagePath,
                onTap: (index) async {
                  if (index == 0) {
                    bloc.add(BlocEvent(MainEvent.onAddStory));
                  } else {
                    bloc.add(BlocEvent(
                      MainEvent.onTapStroy,
                      extra: state.storyDataList[index - 1],
                    ));
                  }
                },
                index: index,
                onLongTap: (index) {
                  if (index == 0) {
                    return;
                  }
                  final storyData = state.storyDataList[index - 1];
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StoryDialog(
                          storyData: storyData,
                          onRemove: (data) {
                            bloc.add(BlocEvent(MainEvent.onRemove, extra: data));
                          },
                        );
                      });
                },
              );
            },
            itemCount: state.storyDataList.length + 1,
          ),
        );
      },
    );
  }

}
