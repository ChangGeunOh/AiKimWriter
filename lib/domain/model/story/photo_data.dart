
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'list_item_data.dart';

class ImageData {
  final Uint8List? thumbData;
  final String address;
  final double latitude;
  final double longitude;
  final String regDate;

  final ListItemData? weatherData;
  final ListItemData? vibeData;

  ImageData({
    this.thumbData,
    this.address = '',
    required this.latitude,
    required this.longitude,
    required this.regDate,
    this.weatherData,
    this.vibeData,
  });
}
