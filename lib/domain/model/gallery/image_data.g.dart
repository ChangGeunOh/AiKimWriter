// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageData _$ImageDataFromJson(Map<String, dynamic> json) => ImageData(
      id: json['id'] as String,
      originalPath: json['originalPath'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String? ?? '',
      weatherData: json['weatherData'] == null
          ? null
          : ListItemData.fromJson(json['weatherData'] as Map<String, dynamic>),
      vibeData: json['vibeData'] == null
          ? null
          : ListItemData.fromJson(json['vibeData'] as Map<String, dynamic>),
      thumbData: Convert.base64ToUint8List(json['thumbData'] as String),
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$ImageDataToJson(ImageData instance) => <String, dynamic>{
      'id': instance.id,
      'vibeData': instance.vibeData,
      'weatherData': instance.weatherData,
      'originalPath': instance.originalPath,
      'thumbData': Convert.uint8ListTobase64(instance.thumbData),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'dateTime': instance.dateTime.toIso8601String(),
      'description': instance.description,
    };
