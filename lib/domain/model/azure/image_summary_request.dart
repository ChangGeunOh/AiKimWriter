import 'package:json_annotation/json_annotation.dart';


part 'image_summary_request.g.dart';


@JsonSerializable()
class ImageSummaryRequest {
  final Meta meta;
  final List<ImageRequestData> datas;

  ImageSummaryRequest({
    required this.meta,
    required this.datas,
  });

  factory ImageSummaryRequest.fromJson(Map<String, dynamic> json) => _$ImageSummaryRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ImageSummaryRequestToJson(this);
}

@JsonSerializable()
class Meta {
  String theme;
  String vibe;
  String days;
  String dataType;

  Meta({
    required this.theme,
    required this.vibe,
    required this.days,
    required this.dataType,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);

}

@JsonSerializable()
class ImageRequestData {
  String fileName;
  String date;
  String vibe;
  Location location;
  String weather;

  ImageRequestData({
    required this.fileName,
    required this.date,
    required this.vibe,
    required this.location,
    required this.weather,
  });

  factory ImageRequestData.fromJson(Map<String, dynamic> json) => _$ImageRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$ImageRequestDataToJson(this);

}

@JsonSerializable()
class Location {
  double lat;
  double lon;
  String address;

  Location({
    required this.lat,
    required this.lon,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

}

