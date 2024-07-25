import '../../../common/const/const.dart';

class Step5Data {
  final String aiStory;
  final String story;

  Step5Data({
    this.aiStory = aiStorySample,
    this.story = '',
  });

  Step5Data copyWith({
    String? aiStory,
    String? story,
  }) {
    return Step5Data(
      aiStory: aiStory ?? this.aiStory,
      story: story ?? this.story,
    );
  }

  bool get isFilled => aiStory.isNotEmpty && story.isNotEmpty;
}

