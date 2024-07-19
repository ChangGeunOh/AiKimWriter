import 'package:aikimwriter/domain/bloc/bloc_state.dart';

import '../../../../domain/model/main/story_data.dart';

class ViewState extends BlocState {

  final StoryData storyData;


  ViewState({
    super.message = '',
    super.isLoading = false,
    required this.storyData,
  });
  @override
  ViewState copyWith({String? message, bool? isLoading}) {
    return ViewState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      storyData: storyData,
    );
  }

}