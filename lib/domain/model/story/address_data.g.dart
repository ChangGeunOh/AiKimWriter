// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
      id: (json['id'] as num?)?.toInt(),
      imageId: json['image_id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      rawData: json['raw_data'] as String,
    );

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_id': instance.imageId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'raw_data': instance.rawData,
    };
