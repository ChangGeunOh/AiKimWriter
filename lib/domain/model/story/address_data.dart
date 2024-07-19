import 'package:json_annotation/json_annotation.dart';

part 'address_data.g.dart';

@JsonSerializable()
class AddressData {
  final int? id;
  @JsonKey(name: 'image_id')
  final String imageId;
  final double latitude;
  final double longitude;
  final String address;
  @JsonKey(name: 'raw_data')
  final String rawData;


  AddressData({
    this.id,
    required this.imageId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.rawData,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}