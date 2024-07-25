import 'package:aikimwriter/domain/model/story/step_5_data.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/story/story_label_data.dart';
import '../widget/story_title.dart';

class StoryPage05 extends StatefulWidget {
  final StoryLabelData storyLabelData;
  final Function(Step5Data) onChanged;

  final Step5Data step5data;

  const StoryPage05({
    super.key,
    required this.storyLabelData,
    required this.onChanged,
    required this.step5data,
  });

  @override
  State<StoryPage05> createState() => _StoryPage01State();
}

class _StoryPage01State extends State<StoryPage05> {

  late Step5Data _step5data;

  final ScrollController _scrollController = ScrollController();
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _step5data = widget.step5data;
    _textEditingController = TextEditingController(text: widget.step5data.aiStory);
    super.initState();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoryTitle(
            iconPath: widget.storyLabelData.iconPath,
            description: widget.storyLabelData.description,
          ),
           Expanded(
            child: GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _textEditingController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24.0,
              right: 24.0,
              bottom: 8.0,
            ),
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                widget.onChanged(
                  _step5data.copyWith(
                    story: _textEditingController.text,
                  ),
                );
              },
              child: const Text('디자인 선택 하러 가요.'),
            ),
          ),
        ],
      ),
    );
  }
}
