

import '../../../../domain/bloc/bloc_state.dart';
import '../../../../domain/model/gallery/album_data.dart';
import '../../../../domain/model/gallery/photo_data.dart';

class GalleryState extends BlocState {

  final List<AlbumData> albumDataList;
  final int page;
  final AlbumData? albumData;
  final bool isShowAlbums;
  final List<PhotoData> photoDataList;
  final List<PhotoData> selectedPhotoDataList;

  GalleryState({
    super.message = '',
    super.isLoading = false,
    this.albumDataList = const [],
    this.page = 0,
    this.albumData,
    this.isShowAlbums = false,
    this.photoDataList = const [],
    this.selectedPhotoDataList = const [],
  });

  @override
  GalleryState copyWith({
    String? message,
    bool? isLoading,
    List<AlbumData>? albumDataList,
    int? page,
    AlbumData? albumData,
    bool? isShowAlbums,
    List<PhotoData>? photoDataList,
    List<PhotoData>? selectedPhotoDataList,
  }) {
    return GalleryState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      albumDataList: albumDataList ?? this.albumDataList,
      page: page ?? this.page,
      albumData: albumData ?? this.albumData,
      isShowAlbums: isShowAlbums ?? this.isShowAlbums,
      photoDataList: photoDataList ?? this.photoDataList,
      selectedPhotoDataList: selectedPhotoDataList ?? this.selectedPhotoDataList,
    );
  }
}
