
import 'package:aikimwriter/domain/model/gallery/album_data.dart';

import '../../../../domain/bloc/bloc_state.dart';
import '../../../../domain/model/gallery/image_data.dart';

class GalleryState extends BlocState {

  final List<AlbumData> albumDataList;
  final int page;
  final List<ImageData> imageDataList;
  final List<ImageData> selectedImageDataList;
  final AlbumData? albumData;
  final bool isShowAlbums;

  GalleryState({
    super.message = '',
    super.isLoading = false,
    this.albumDataList = const [],
    this.page = 0,
    this.imageDataList = const [],
    this.selectedImageDataList = const [],
    this.albumData,
    this.isShowAlbums = false,
  });

  @override
  GalleryState copyWith({
    String? message,
    bool? isLoading,
    List<AlbumData>? albumDataList,
    int? page,
    List<ImageData>? imageDataList,
    AlbumData? albumData,
    bool? isShowAlbums,
    List<ImageData>? selectedImageDataList,
  }) {
    return GalleryState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      albumDataList: albumDataList ?? this.albumDataList,
      page: page ?? this.page,
      imageDataList: imageDataList ?? this.imageDataList,
      albumData: albumData ?? this.albumData,
      isShowAlbums: isShowAlbums ?? this.isShowAlbums,
      selectedImageDataList: selectedImageDataList ?? this.selectedImageDataList,
    );
  }
}
