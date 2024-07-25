
import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class PhotoData {
  final Uint8List thumbData;
  final bool hasLocation;
  final AssetEntity assetEntity;

  PhotoData({
    required this.thumbData,
    required this.assetEntity,
    required this.hasLocation,
  });
}