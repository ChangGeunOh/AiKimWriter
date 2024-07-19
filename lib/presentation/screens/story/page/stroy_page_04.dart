import 'package:aikimwriter/common/const/const.dart';
import 'package:aikimwriter/domain/model/story/step_4_data.dart';
import 'package:aikimwriter/presentation/screens/story/widget/image_text_list_view.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/story/story_label_data.dart';
import '../widget/dropdown_text_field.dart';
import '../widget/story_title.dart';

class StoryPage04 extends StatefulWidget {
  final Step4Data step4data;
  final StoryLabelData storyLabelData;
  final Function(Step4Data) onChanged;

  const StoryPage04({
    super.key,
    required this.step4data,
    required this.storyLabelData,
    required this.onChanged,
  });

  @override
  State<StoryPage04> createState() => _StoryPage01State();
}

class _StoryPage01State extends State<StoryPage04> {
  late Step4Data _step4data;
  final ScrollController _scrollController = ScrollController();
  List<String> _textStyleList = [];

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    _step4data = widget.step4data;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_step4data.filledData);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoryTitle(
            iconPath: widget.storyLabelData.iconPath,
            description: widget.storyLabelData.description,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return DropdownTextField(
                        text: _step4data.title,
                        items: _step4data.titleList,
                        onChanged: (value) {
                          print('title: $value');
                          _step4data = _step4data.copyWith(title: value);
                          setState(() {});
                        },
                      );
                    case 2:
                      return DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: '글 스타일',
                        ),
                        value: _textStyleList.isEmpty ? '' : _textStyleList.first,
                        items: _textStyleList
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          _step4data = _step4data.copyWith(textStyle: value);
                          setState(() {});
                        },
                      );
                    case 1:
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ImageTextListView(
                          title: '글 유형',
                          onTapBookType: (booktype) {
                            _step4data = _step4data.copyWith(bookType: booktype);
                            setState(() {});
                            _textStyleList = textStyleMap[booktype.type]!;
                            _scrollController;
                          },
                          bookTypeList: bookTypeList,
                        ),
                      );
                    case 3:
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          left: 24.0,
                          right: 24.0,
                          bottom: 8.0,
                        ),
                        child: ElevatedButton(
                          onPressed: _step4data.isFilled
                              ? () => widget.onChanged(_step4data)
                              : null,
                          child: const Text('AI 김작가 작성글을 확인 해요.'),
                        ),
                      );
                  }
                  return const SizedBox();
                },
                itemCount: 4,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
