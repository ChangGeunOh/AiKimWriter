
import 'package:aikimwriter/domain/model/story/step_7_data.dart';

import '../../../../domain/bloc/bloc_state.dart';
import '../../../../domain/model/gallery/image_data.dart';
import '../../../../domain/model/story/step_3_data.dart';
import '../../../../domain/model/story/step_4_data.dart';
import '../../../../domain/model/story/step_5_data.dart';
import '../../../../domain/model/story/step_6_data.dart';

class StoryState extends BlocState {
  final List<ImageData> imageDataList;
  final int step;
  final String travelType;
  final Step3Data step3Data;
  final Step4Data step4Data;
  final Step5Data step5Data;
  final Step6Data step6Data;
  final Step7Data step7Data;

  StoryState({
    super.message = '',
    super.isLoading = false,
    this.imageDataList = const [],
    this.step = 1,
    this.travelType = '',
    Step3Data? step3Data,
    Step4Data? step4Data,
    Step5Data? step5Data,
    Step6Data? step6Data,
    Step7Data? step7Data,
  }): step3Data = step3Data ?? Step3Data(),
      step4Data = step4Data ?? Step4Data(),
      step5Data = step5Data ?? Step5Data(),
      step6Data = step6Data ?? Step6Data(),
      step7Data = step7Data ?? Step7Data();

  @override
  StoryState copyWith({
    String? message,
    bool? isLoading,
    List<ImageData>? imageDataList,
    int? step,
    String? travelType,
    Step3Data? step3Data,
    Step4Data? step4Data,
    Step5Data? step5Data,
    Step6Data? step6Data,
    Step7Data? step7Data,
  }) {
    return StoryState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      imageDataList: imageDataList ?? this.imageDataList,
      step: step ?? this.step,
      travelType: travelType ?? this.travelType,
      step3Data: step3Data ?? this.step3Data,
      step4Data: step4Data ?? this.step4Data,
      step5Data: step5Data ?? this.step5Data,
      step6Data: step6Data ?? this.step6Data,
      step7Data: step7Data ?? this.step7Data,
    );
  }
}
