import 'package:aikimwriter/domain/model/story/step_6_data.dart';
import 'package:aikimwriter/presentation/screens/story/widget/cover_list_view.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/story/story_label_data.dart';
import '../widget/story_title.dart';

class StoryPage06 extends StatefulWidget {
  final Step6Data step6data;
  final StoryLabelData storyLabelData;
  final Function(Step6Data) onChanged;

  const StoryPage06({
    super.key,
    required this.step6data,
    required this.storyLabelData,
    required this.onChanged,
  });

  @override
  State<StoryPage06> createState() => _StoryPage01State();
}

class _StoryPage01State extends State<StoryPage06> {
  late Step6Data _step6data;
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
  @override
  void initState() {
    _step6data = widget.step6data;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        StoryTitle(
          iconPath: widget.storyLabelData.iconPath,
          description: widget.storyLabelData.description,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView.separated(
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CoverListView(
                    title: '표지',
                    coverImage: '',
                    coverImageList: ['assets/images/img_book_type_01.png', 'assets/images/img_book_type_02.png'],
                    onTapCoverImage: (coverImage) {
                      _step6data = _step6data.copyWith(coverImage: coverImage);
                      setState(() {});
                    },
                  );
                }
                if (index == 1) {
                  return CoverListView(
                    title: '속지',
                    coverImage: '',
                    coverImageList: ['assets/images/img_page_type_01.png', 'assets/images/img_page_type_02.png', 'assets/images/img_page_type_03.png'],
                    onTapCoverImage: (innerImage) {
                      _step6data = _step6data.copyWith(innerImage: innerImage);
                      setState(() {});
                    },
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 56,
                    left: 24.0,
                    right: 24.0,
                    bottom: 8.0,
                  ),
                  child: ElevatedButton(
                    onPressed: _step6data.isValidate ?  () {
                      widget.onChanged(_step6data);
                    } : null,
                    child: const Text('다 끝났 어요.'),
                  ),
                );
              },
              itemCount: 3,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16);
              },
            ),
          ),
        ),
      ]),
    );
  }
}
