import 'package:json_annotation/json_annotation.dart';

part 'image_summary_response.g.dart';


@JsonSerializable()
class ImageSummaryResponse {
  final String status;
  @JsonKey(name: 'session_id')
  final String sessionId;
  @JsonKey(name: 'blob_dir_list')
  final List<FileNameImageDir> blobDirList;
  @JsonKey(name: 'chunked_list')
  final List<ChunkedList> chunkedList;

  ImageSummaryResponse({
    required this.status,
    required this.sessionId,
    required this.blobDirList,
    required this.chunkedList,
  });

  factory ImageSummaryResponse.fromJson(Map<String, dynamic> json) => _$ImageSummaryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ImageSummaryResponseToJson(this);
}


@JsonSerializable()
class ChunkedList {
  final int subSequence;
  final List<FileNameImageDir> chunk;

  ChunkedList({
    required this.subSequence,
    required this.chunk,
  });

  factory ChunkedList.fromJson(Map<String, dynamic> json) => _$ChunkedListFromJson(json);
  Map<String, dynamic> toJson() => _$ChunkedListToJson(this);
}


@JsonSerializable()
class FileNameImageDir {
  final String fileName;
  final String imageDir;

  FileNameImageDir({
    required this.fileName,
    required this.imageDir,
  });

  factory FileNameImageDir.fromJson(Map<String, dynamic> json) => _$FileNameImageDirFromJson(json);
  Map<String, dynamic> toJson() => _$FileNameImageDirToJson(this);
}
