// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_address_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherAddressData _$WeatherAddressDataFromJson(Map<String, dynamic> json) =>
    WeatherAddressData(
      id: json['id'] as String,
      weather: json['weather'] as String,
      address: json['address'] as String,
      vibe: json['vibe'] as String? ?? '',
    );

Map<String, dynamic> _$WeatherAddressDataToJson(WeatherAddressData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weather': instance.weather,
      'address': instance.address,
      'vibe': instance.vibe,
    };
