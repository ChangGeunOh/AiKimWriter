import 'package:aikimwriter/data/repository/repository.dart';
import 'package:aikimwriter/domain/model/gallery/image_data.dart';
import 'package:photo_manager/src/types/entity.dart';

import '../../data/repository/gallery_repository.dart';

class GalleryCase {
  final Repository _repository;

  GalleryCase({
    required Repository repository,
  }) : _repository = repository;

  Future<List<ImageData>> getImageDataList(
      {required AssetPathEntity assetPath, required int page}) {
    return _repository.getImageDataList(assetPath: assetPath, page: page);
  }

  Future<String> getAddress({
    required String imageId,
    required double latitude,
    required double longitude,
  }) {
    return _repository.getAddress(
      imageId: imageId,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
 