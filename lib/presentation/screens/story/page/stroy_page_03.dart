import 'package:aikimwriter/domain/model/story/step_3_data.dart';
import 'package:aikimwriter/presentation/widgets/memo_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/gallery/image_data.dart';
import '../../../../domain/model/story/story_label_data.dart';
import '../../../widgets/custom_text_field.dart';
import '../widget/duration_text_field.dart';
import '../widget/image_list_view.dart';
import '../widget/story_title.dart';

class StoryPage03 extends StatefulWidget {
  final Step3Data step3data;
  final StoryLabelData storyLabelData;
  final List<ImageData> imageDataList;
  final Function(Step3Data) onChanged;

  const StoryPage03({
    super.key,
    required this.step3data,
    required this.storyLabelData,
    required this.imageDataList,
    required this.onChanged,
  });

  @override
  State<StoryPage03> createState() => _StoryPage01State();
}

class _StoryPage01State extends State<StoryPage03> {
  late Step3Data _step3data;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _step3data = widget.step3data.copyWith(
        dateTimeRange: findDateRange(
      widget.imageDataList,
    ));
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return _buildWidget(
                      index: index,
                      step3data: _step3data,
                      onChanged: (data) {
                        _step3data = data;
                        setState(() {});
                      },
                      onTapNext: () {
                        FocusScope.of(context).unfocus();
                        widget.onChanged(_step3data);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 24);
                  },
                  itemCount: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidget({
    required int index,
    required Step3Data step3data,
    required Function(Step3Data) onChanged,
    required VoidCallback onTapNext,
  }) {
    switch (index) {
      case 0:
        return CustomTextField(
          text: step3data.travelPlace,
          onChanged: (value) {
            onChanged(step3data.copyWith(location: value));
          },
          labelText: '여행장소',
          hintText: '여행 장소를 입력하세요.',
        );
      case 1:
        return DurationTextField(
          onChanged: (value) {
            onChanged(step3data.copyWith(dateTimeRange: value));
          },
          dateTimeRange: findDateRange(widget.imageDataList),
          labelText: '여행기간',
          hintText: '여행 기간을 입력하세요.',
        );
      case 2:
        return ImageListView(
          imageData: step3data.imageData,
          imageDataList: widget.imageDataList,
          title: '대표사진',
          onTapImageData: (imageData) {
            onChanged(step3data.copyWith(imageData: imageData));
            _scrollToBottom();
          },
        );
      case 3:
        return MemoTextField(
          onChanged: (text) {
            print('text: $text');
            onChanged(step3data.copyWith(memo: text));
          },
          text: step3data.memo,
          labelText: '여행후기',
        );
      case 4:
        return Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 24.0,
            right: 24.0,
            bottom: 8.0,
          ),
          child: ElevatedButton(
            onPressed: step3data.isFilled ? onTapNext : null,
            child: const Text('출력을 유형을 선택해 주세요.'),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  DateTimeRange findDateRange(List<ImageData> images) {
    if (images.isEmpty) {
      return DateTimeRange(start: DateTime.now(), end: DateTime.now());
    }

    DateTime minDate = images.first.dateTime;
    DateTime maxDate = images.first.dateTime;

    for (var image in images) {
      if (image.dateTime.isBefore(minDate)) {
        minDate = image.dateTime;
      }
      if (image.dateTime.isAfter(maxDate)) {
        maxDate = image.dateTime;
      }
    }

    return DateTimeRange(start: minDate, end: maxDate);
  }
}
