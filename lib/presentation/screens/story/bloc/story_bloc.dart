import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aikimwriter/common/utils/extension.dart';
import 'package:aikimwriter/common/utils/pdf_maker.dart';
import 'package:aikimwriter/domain/model/gallery/photo_data.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:aikimwriter/domain/model/story/step_3_data.dart';
import 'package:aikimwriter/domain/model/story/step_4_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/bloc/bloc_bloc.dart';
import '../../../../domain/bloc/bloc_event.dart';
import '../../../../domain/model/azure/image_summary_request.dart';
import '../../../../domain/model/gallery/image_data.dart';
import '../../../../domain/model/main/story_data.dart';
import '../../../../domain/model/story/step_5_data.dart';
import '../../../../domain/model/story/step_6_data.dart';
import '../../../../domain/model/story/step_7_data.dart';
import '../../gallery/gallery_screen.dart';
import 'story_event.dart';
import 'story_state.dart';

import 'package:http/http.dart' as http;

class StoryBloc extends BlocBloc<BlocEvent<StoryEvent>, StoryState> {
  late PageController pageController;

  final dio = Dio();

  StoryBloc(
    super.context,
    super.initialState,
  ) {
    pageController = PageController();
    init();
  }

  void init() async {
    add(BlocEvent(StoryEvent.init));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  @override
  Future<void> onBlocEvent(
    BlocEvent<StoryEvent> event,
    Emitter<StoryState> emit,
  ) async {
    switch (event.type) {
      case StoryEvent.init:
        break;
      case StoryEvent.onTapGallery:
        final List<PhotoData>? result =
            await context.pushNamed(GalleryScreen.routeName);
        if (result != null) {
          final List<ImageData> imageDataList = [];
          for (final photoData in result) {
            final originalFile = await photoData.assetEntity.originFile;
            final originalPath = originalFile?.path ?? '';
            final imageData = ImageData(
              id: photoData.assetEntity.id,
              thumbData: photoData.thumbData,
              dateTime: photoData.assetEntity.createDateTime,
              latitude: photoData.assetEntity.latitude,
              longitude: photoData.assetEntity.longitude,
              originalPath: originalPath,
            );
            imageDataList.add(imageData);
          }
          emit(state.copyWith(
            imageDataList: imageDataList,
          ));
        }
        break;
      case StoryEvent.onTapStep:
        final step = event.extra as int;
        pageController.animateToPage(
          step - 1,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.easeInOut,
        );
        emit(state.copyWith(
          step: step,
        ));
        break;
      case StoryEvent.onTravelType:
        emit(state.copyWith(
          travelType: event.extra as String,
          step: 2,
        ));
        goToPage(1);
        break;
      case StoryEvent.onImageList:
        emit(state.copyWith(
          imageDataList: event.extra as List<ImageData>,
          step: 3,
        ));
        goToPage(2);
        break;
      case StoryEvent.onStep3Data:
        emit(state.copyWith(
          step3Data: event.extra as Step3Data,
          step: 4,
        ));
        goToPage(3);
        postSummaryImage();
      // _makePostRequest();
      case StoryEvent.onStep4Data:
        emit(state.copyWith(
          step4Data: event.extra as Step4Data,
          step: 5,
        ));
        goToPage(4);
        break;
      case StoryEvent.onStep5Data:
        emit(state.copyWith(
          step5Data: event.extra as Step5Data,
          step: 6,
        ));
        goToPage(5);
        break;
      case StoryEvent.onStep6Data:
        emit(state.copyWith(
          step6Data: event.extra as Step6Data,
          step: 7,
        ));
        goToPage(6);
        break;
      case StoryEvent.onStep7Data:
        emit(state.copyWith(
          step7Data: event.extra as Step7Data,
          step: 8,
        ));
        goToPage(6);
      case StoryEvent.onDone:
        final storyData = StoryData(
          id: DateTime.now().millisecond,
          travelType: state.travelType,
          travelPlace: state.step3Data.travelPlace,
          travelDate: state.step3Data.dateTimeRange ??
              DateTimeRange(
                start: DateTime.now(),
                end: DateTime.now(),
              ),
          travelReview: state.step3Data.memo,
          imageDataList: state.imageDataList,
          coverImage: state.step3Data.imageData!,
          titleList: state.step4Data.titleList,
          bookTitle: state.step4Data.title,
          bookAuthor: '',
          bookGenre: state.step4Data.bookType!.type,
          bookStyle: state.step4Data.textStyle,
          aiStory: state.step5Data.aiStory,
          story: state.step5Data.story,
          coverStyle: state.step6Data.coverImage,
          innerStyle: state.step6Data.innerImage,
          pdfPath: state.step7Data.filePath,
          coverImagePath: state.step7Data.coverImage,
        );
        context.pop(storyData);
        break;
    }
  }

  void goToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> postSummaryImage() async {

    final List<MultipartFile> multipartFiles = [];
    for (final imageData in state.imageDataList) {
      final filePath = imageData.id.split('/').first;
      final file = await _writeToFile(imageData.thumbData!, filePath);
      final multipartFile = await MultipartFile.fromFile(file.path,
          filename: filePath.split('/').last);
      multipartFiles.add(multipartFile);
    }

    final List<ImageRequestData> imageRequestDataList =
        state.imageDataList.mapIndexed((index, imageData) {
      final location = Location(
        lat: imageData.latitude,
        lon: imageData.longitude,
        address: imageData.address,
      );
      return ImageRequestData(
        fileName: imageData.id.split('/').first,
        date: imageData.dateTime.toDateTimeString(),
        vibe: '${imageData.vibeData?.description} ${imageData.description}',
        location: location,
        weather: imageData.weatherData?.description ?? '',
      );
    }).toList();

    final imageSummaryRequest = ImageSummaryRequest(
      meta: Meta(
        theme: state.travelType,
        vibe: state.step3Data.memo,
        days: state.step3Data.dateTimeRange?.toNightDays() ?? '',
        dataType: 'image',
      ),
      datas: imageRequestDataList,
    );

    final imageSummaryResponse = await usesCases.storyCase.postImageSummary(
      files: multipartFiles,
      desc: imageSummaryRequest,
    );

    // print (imageSummaryResponse.toString());

    // final desc = {
    //   "meta": {
    //     "theme": "나홀로 여행",
    //     "vibe": "",
    //     "days": "2145/2146",
    //     "dataType": "image"
    //   },
    //   "datas": [
    //     {
    //       "fileName": "F34E3C91-91D4-450F-A3EF-4501711D84D3",
    //       "date": "2024/02/13 21:59",
    //       "vibe": "null ",
    //       "location": {
    //         "lat": 46.54750333333333,
    //         "lon": 7.980951666666667,
    //         "address": "Jungfraujoch, 3801 Fieschertal, 스위스"
    //       },
    //       "weather": ""
    //     },
    //     {
    //       "fileName": "CC95F08C-88C3-4012-9D6D-64A413D254B3",
    //       "date": "2018/03/31 04:14",
    //       "vibe": "null ",
    //       "location": {
    //         "lat": 37.76007833333333,
    //         "lon": -122.50956666666667,
    //         "address": "1401 Great Hwy, San Francisco, CA 94122 미국"
    //       },
    //       "weather": ""
    //     }
    //   ]
    // };
    //
    // final formData = FormData.fromMap({
    //   'desc':
    //       '''{"meta":{"theme":"나홀로 여행","vibe":"","days":"2145/2146","dataType":"image"},"datas":[]}''',
    //   // 'file1': await MultipartFile.fromFile('path/to/file1.png', filename: 'file1.png'),
    //   // 'file2': await MultipartFile.fromFile('path/to/file2.png', filename: 'file2.png'),
    //   // 필요한 경우 파일을 포함하려면 위 주석을 해제하고 파일 경로를 지정합니다.
    // });
    //
    // const url =
    //     'https://team10-api.azurewebsites.net/api/travel/summary/pictures/async?code=C79kRLGqSxxEmjdevTpETK7HlMUfR7cayozj_ltFUyWMAzFupHr1-A%3D%3D';
    //
    // try {
    //   final response = await Dio().post(
    //     url,
    //     data: formData,
    //     options: Options(
    //       headers: {
    //         'Content-Type': 'multipart/form-data',
    //       },
    //     ),
    //   );
    //   print('Response: ${response.data}');
    // } catch (e) {
    //   print('Request error: $e');
    // }

    // Options options = Options(
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // final response = await Dio().post(
    //     'https://team10-api.azurewebsites.net/api/travel/summary/pictures/async?code=C79kRLGqSxxEmjdevTpETK7HlMUfR7cayozj_ltFUyWMAzFupHr1-A%3D%3D',
    //     data: {"desc": imageSummaryRequest.toJson()});
    // print('response: ${response.data}');
    // // print('imageSummaryResponse: $imageSummaryResponse');
  }

  Future<File> _writeToFile(Uint8List data, String fileName) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');
    print('file: ${file.path}');
    return file.writeAsBytes(data);
  }

  Future<void> _makePostRequest() async {
    // final response = usesCases.storyCase.postImageSummary(files: files, desc: desc);

    final client = http.Client();

    final url = Uri.parse(
        'https://team10-api.azurewebsites.net/api/travel/summary/pictures/async?code=C79kRLGqSxxEmjdevTpETK7HlMUfR7cayozj_ltFUyWMAzFupHr1-A%3D%3D');

    final response = await http.post(url,
        body: {"desc": "{\"meta\": {\"theme\": \"\"},\"datas\": []}"});
    print(response.statusCode);

    final request = http.MultipartRequest('POST', url);

    final desc = jsonEncode({
      "meta": {"theme": ""},
      "datas": []
    });

    request.fields['desc'] = "{\"meta\": {\"theme\": \"\"},\"datas\": []}";

    try {
      final response = await client.send(request);
      final responseBody = await http.Response.fromStream(response);

      if (responseBody.statusCode == 200) {
        print(responseBody.body);
      } else {
        print('Request failed with status: ${responseBody.statusCode}');
        print(responseBody.body);
      }
    } catch (e) {
      print('Request error: $e');
    } finally {
      client.close();
    }
  }
}
