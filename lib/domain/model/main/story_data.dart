import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../common/utils/convert.dart';
import '../gallery/image_data.dart';

part 'story_data.g.dart';

@JsonSerializable()
class StoryData {
  final int? id;
  final String travelType;
  final String travelPlace;
  @JsonKey(
    fromJson: Convert.mapToDateTimeRange,
    toJson: Convert.dateTimeRangeToMap,
  )
  final DateTimeRange travelDate;
  final String travelReview;
  final List<ImageData> imageDataList;
  final ImageData coverImage;

  final List<String> titleList;
  final String bookTitle;
  final String bookAuthor;
  final String bookGenre;
  final String bookStyle;
  final String aiStory;
  final String story;

  final String coverStyle;
  final String innerStyle;

  final String pdfPath;
  final String coverImagePath;

  final DateTime regDate;

  StoryData({
    this.id,
    required this.travelType,
    required this.travelPlace,
    required this.travelDate,
    required this.travelReview,
    required this.imageDataList,
    required this.coverImage,
    required this.titleList,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookGenre,
    required this.bookStyle,
    required this.aiStory,
    required this.story,
    required this.coverStyle,
    required this.innerStyle,
    required this.pdfPath,
    required this.coverImagePath,
    DateTime? regDate,
  }) : regDate = regDate ?? DateTime.now();

  StoryData copyWith({
    int? id,
    String? travelType,
    String? travelPlace,
    DateTimeRange? travelDate,
    String? travelReview,
    List<ImageData>? imageDataList,
    ImageData? coverImage,
    List<String>? titleList,
    String? bookTitle,
    String? bookAuthor,
    String? bookGenre,
    String? bookStyle,
    String? aiStory,
    String? story,
    String? coverStyle,
    String? innerStyle,
    List<String>? bookPageList,
    DateTime? regDate,
    String? pdfPath,
    String? coverImagePath,
  }) {
    return StoryData(
      id: id ?? this.id,
      travelType: travelType ?? this.travelType,
      travelPlace: travelPlace ?? this.travelPlace,
      travelDate: travelDate ?? this.travelDate,
      travelReview: travelReview ?? this.travelReview,
      imageDataList: imageDataList ?? this.imageDataList,
      coverImage: coverImage ?? this.coverImage,
      titleList: titleList ?? this.titleList,
      bookTitle: bookTitle ?? this.bookTitle,
      bookAuthor: bookAuthor ?? this.bookAuthor,
      bookGenre: bookGenre ?? this.bookGenre,
      bookStyle: bookStyle ?? this.bookStyle,
      aiStory: aiStory ?? this.aiStory,
      story: story ?? this.story,
      coverStyle: coverStyle ?? this.coverStyle,
      innerStyle: innerStyle ?? this.innerStyle,
      regDate: regDate ?? this.regDate,
      pdfPath: pdfPath ?? this.pdfPath,
      coverImagePath: coverImagePath ?? this.coverImagePath,
    );
  }

  factory StoryData.fromJson(Map<String, dynamic> json) => _$StoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$StoryDataToJson(this);
}
