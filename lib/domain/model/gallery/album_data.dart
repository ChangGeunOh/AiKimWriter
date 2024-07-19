import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class AlbumData {
  final String id;
  final String name;
  final String krName;
  final Uint8List? coverImage;
  final int count;
  final AssetPathEntity assetPath;

  AlbumData({
    required this.id,
    required this.name,
    this.krName = '',
    this.coverImage,
    required this.count,
    required this.assetPath,
  });
}
