import 'dart:io';

import 'package:aikimwriter/domain/model/azure/image_summary_request.dart';
import 'package:aikimwriter/domain/model/main/story_data.dart';
import 'package:dio/dio.dart';

import '../../data/repository/repository.dart';
import '../model/azure/image_summary_response.dart';

class StoryCase {
  final Repository _repository;

  StoryCase({
    required Repository repository,
  }) : _repository = repository;

  Future<void> postImageSummary({
    required List<MultipartFile> files,
    required ImageSummaryRequest desc,
  }) {
    return _repository.postImageSummary(
      files: files,
      desc: desc,
    );
  }

  Future<void> saveStoryData(StoryData storyData) {
    return _repository.saveStoryData(storyData);
  }

  Future<List<StoryData>> loadStoryDataList() {
    return _repository.loadStoryDataList();
  }

  Future<void> removeStoryData(StoryData storyData) {
    return _repository.removeStoryData(storyData);
  }

}
