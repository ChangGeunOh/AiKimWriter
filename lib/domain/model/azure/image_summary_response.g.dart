// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageSummaryResponse _$ImageSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    ImageSummaryResponse(
      status: json['status'] as String,
      sessionId: json['session_id'] as String,
      blobDirList: (json['blob_dir_list'] as List<dynamic>)
          .map((e) => FileNameImageDir.fromJson(e as Map<String, dynamic>))
          .toList(),
      chunkedList: (json['chunked_list'] as List<dynamic>)
          .map((e) => ChunkedList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImageSummaryResponseToJson(
        ImageSummaryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'session_id': instance.sessionId,
      'blob_dir_list': instance.blobDirList,
      'chunked_list': instance.chunkedList,
    };

ChunkedList _$ChunkedListFromJson(Map<String, dynamic> json) => ChunkedList(
      subSequence: (json['subSequence'] as num).toInt(),
      chunk: (json['chunk'] as List<dynamic>)
          .map((e) => FileNameImageDir.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChunkedListToJson(ChunkedList instance) =>
    <String, dynamic>{
      'subSequence': instance.subSequence,
      'chunk': instance.chunk,
    };

FileNameImageDir _$FileNameImageDirFromJson(Map<String, dynamic> json) =>
    FileNameImageDir(
      fileName: json['fileName'] as String,
      imageDir: json['imageDir'] as String,
    );

Map<String, dynamic> _$FileNameImageDirToJson(FileNameImageDir instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'imageDir': instance.imageDir,
    };
