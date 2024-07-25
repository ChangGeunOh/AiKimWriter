// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_summary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageSummaryRequest _$ImageSummaryRequestFromJson(Map<String, dynamic> json) =>
    ImageSummaryRequest(
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      datas: (json['datas'] as List<dynamic>)
          .map((e) => ImageRequestData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImageSummaryRequestToJson(
        ImageSummaryRequest instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'datas': instance.datas,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      theme: json['theme'] as String,
      vibe: json['vibe'] as String,
      days: json['days'] as String,
      dataType: json['dataType'] as String,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'theme': instance.theme,
      'vibe': instance.vibe,
      'days': instance.days,
      'dataType': instance.dataType,
    };

ImageRequestData _$ImageRequestDataFromJson(Map<String, dynamic> json) =>
    ImageRequestData(
      fileName: json['fileName'] as String,
      date: json['date'] as String,
      vibe: json['vibe'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      weather: json['weather'] as String,
    );

Map<String, dynamic> _$ImageRequestDataToJson(ImageRequestData instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'date': instance.date,
      'vibe': instance.vibe,
      'location': instance.location,
      'weather': instance.weather,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      address: json['address'] as String,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'address': instance.address,
    };
