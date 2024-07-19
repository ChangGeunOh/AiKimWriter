import 'package:aikimwriter/domain/bloc/bloc_state.dart';

import '../../../../domain/model/main/story_data.dart';

class MainState extends BlocState {

  final List<StoryData> storyDataList;
  MainState({
    super.message = '',
    super.isLoading = false,
    this.storyDataList = const [],
  });

  @override
  MainState copyWith({
    String? message,
    bool? isLoading,
    List<StoryData>? storyDataList,
  }) {
    return MainState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      storyDataList: storyDataList ?? this.storyDataList,
    );
  }
}
