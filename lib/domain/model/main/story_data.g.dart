// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryData _$StoryDataFromJson(Map<String, dynamic> json) => StoryData(
      id: (json['id'] as num?)?.toInt(),
      travelType: json['travelType'] as String,
      travelPlace: json['travelPlace'] as String,
      travelDate: Convert.mapToDateTimeRange(
          json['travelDate'] as Map<String, dynamic>),
      travelReview: json['travelReview'] as String,
      imageDataList: (json['imageDataList'] as List<dynamic>)
          .map((e) => ImageData.fromJson(e as Map<String, dynamic>))
          .toList(),
      coverImage:
          ImageData.fromJson(json['coverImage'] as Map<String, dynamic>),
      titleList:
          (json['titleList'] as List<dynamic>).map((e) => e as String).toList(),
      bookTitle: json['bookTitle'] as String,
      bookAuthor: json['bookAuthor'] as String,
      bookGenre: json['bookGenre'] as String,
      bookStyle: json['bookStyle'] as String,
      aiStory: json['aiStory'] as String,
      story: json['story'] as String,
      coverStyle: json['coverStyle'] as String,
      innerStyle: json['innerStyle'] as String,
      pdfPath: json['pdfPath'] as String,
      coverImagePath: json['coverImagePath'] as String,
      regDate: json['regDate'] == null
          ? null
          : DateTime.parse(json['regDate'] as String),
    );

Map<String, dynamic> _$StoryDataToJson(StoryData instance) => <String, dynamic>{
      'id': instance.id,
      'travelType': instance.travelType,
      'travelPlace': instance.travelPlace,
      'travelDate': Convert.dateTimeRangeToMap(instance.travelDate),
      'travelReview': instance.travelReview,
      'imageDataList': instance.imageDataList,
      'coverImage': instance.coverImage,
      'titleList': instance.titleList,
      'bookTitle': instance.bookTitle,
      'bookAuthor': instance.bookAuthor,
      'bookGenre': instance.bookGenre,
      'bookStyle': instance.bookStyle,
      'aiStory': instance.aiStory,
      'story': instance.story,
      'coverStyle': instance.coverStyle,
      'innerStyle': instance.innerStyle,
      'pdfPath': instance.pdfPath,
      'coverImagePath': instance.coverImagePath,
      'regDate': instance.regDate.toIso8601String(),
    };
