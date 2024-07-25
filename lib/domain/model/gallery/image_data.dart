import 'dart:typed_data';

import 'package:aikimwriter/domain/model/story/list_item_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../common/utils/convert.dart';

part 'image_data.g.dart';

@JsonSerializable()
class ImageData {
  final String id;
  final ListItemData? vibeData;
  final ListItemData? weatherData;
  final String originalPath;
  @JsonKey(
    fromJson: Convert.base64ToUint8List,
    toJson: Convert.uint8ListTobase64,
  )
  final Uint8List? thumbData;
  final double latitude;
  final double longitude;
  final String address;
  final DateTime dateTime;
  final String description;

  ImageData({
    required this.id,
    required this.originalPath,
    required this.dateTime,
    double? latitude,
    double? longitude,
    this.address = '',
    this.weatherData,
    this.vibeData,
    this.thumbData,
    this.description = '',
  })  : latitude = latitude ?? 0,
        longitude = longitude ?? 0;

  bool get hasLocation => latitude != 0 && longitude != 0;

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);


  Map<String, dynamic> toJson() => _$ImageDataToJson(this);

  ImageData copyWith({
    String? address,
    String? description,
    double? latitude,
    double? longitude,
    ListItemData? vibeData,
    ListItemData? weatherData,
    Uint8List? thumbData,
    DateTime? dateTime,
  }) {
    return ImageData(
      id: id,
      originalPath: originalPath,
      dateTime: dateTime ?? this.dateTime,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      description: description ?? this.description,
      vibeData: vibeData ?? this.vibeData,
      weatherData: weatherData ?? this.weatherData,
      thumbData: thumbData ?? this.thumbData,
    );
  }

  bool get isValidate =>  address.isNotEmpty && weatherData != null && vibeData != null;
}
