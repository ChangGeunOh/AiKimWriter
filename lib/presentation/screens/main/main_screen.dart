import 'package:flutter/material.dart';

import '../../../common/const/color.dart';
import '../../../domain/bloc/bloc_event.dart';
import '../../../domain/bloc/bloc_scaffold.dart';
import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';
import 'bloc/main_state.dart';
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
                    : state.storyDataList[index - 1].bookPageList.first,
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
              );
            },
            itemCount: state.storyDataList.length + 1,
          ),
        );
      },
    );
  }
}

class StoryGridAddItem extends StatelessWidget {
  final int index;
  final String imagePath;
  final Function(int) onTap;

  const StoryGridAddItem({
    super.key,
    required this.index,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          onTap(index);
        },
        child: imagePath.isEmpty ? getAddItem() : getImageItem(imagePath),
      ),
    );
  }

  Widget getAddItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/ic_story_step_06.png',
          width: 48,
          height: 48,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 12),
        Text(
          'Add Story'.toUpperCase(),
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget getImageItem(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
