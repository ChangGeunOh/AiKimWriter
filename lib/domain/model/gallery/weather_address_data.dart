import 'package:json_annotation/json_annotation.dart';

part 'weather_address_data.g.dart';

@JsonSerializable()
class WeatherAddressData {
  final String id;
  final String weather;
  final String address;
  final String vibe;

  WeatherAddressData({
    required this.id,
    required this.weather,
    required this.address,
    this.vibe = '',
  });

  WeatherAddressData copyWith({
    String? id,
    String? weather,
    String? address,
    String? vibe,
  }) =>
      WeatherAddressData(
        id: id ?? this.id,
        weather: weather ?? this.weather,
        address: address ?? this.address,
        vibe: vibe ?? this.vibe,
      );

  factory WeatherAddressData.fromJson(Map<String, dynamic> json) =>
      _$WeatherAddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherAddressDataToJson(this);
}