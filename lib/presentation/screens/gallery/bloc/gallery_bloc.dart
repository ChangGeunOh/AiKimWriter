import 'dart:async';
import 'dart:typed_data';

import 'package:aikimwriter/common/const/const.dart';
import 'package:aikimwriter/domain/model/gallery/album_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../domain/bloc/bloc_bloc.dart';
import '../../../../domain/bloc/bloc_event.dart';
import '../../../../domain/model/gallery/image_data.dart';
import '../../../../domain/model/gallery/photo_data.dart';
import 'gallery_event.dart';
import 'gallery_state.dart';

class GalleryBloc extends BlocBloc<BlocEvent<GalleryEvent>, GalleryState> {
  GalleryBloc(super.context, super.initialState) {
    add(BlocEvent(GalleryEvent.init));
  }

  bool isLoading = false;

  @override
  Future<FutureOr<void>> onBlocEvent(
    BlocEvent<GalleryEvent> event,
    Emitter<GalleryState> emit,
  ) async {
    switch (event.type) {
      case GalleryEvent.init:
        final result = await _requestPermission();
        if (!result) {
          emit(state.copyWith(message: '원할한 서비스 제공을 위해 권한을 설정해 주세요.'));
          if (context.mounted) context.pop();
        }
        final albumList = await _loadAlbums();
        emit(state.copyWith(
          albumDataList: albumList,
          albumData: albumList.firstOrNull,
        ));
        add(BlocEvent(GalleryEvent.onLoadingImages, extra: 0));
        break;
      case GalleryEvent.onLoadingImages:
        final page = event.extra as int;
        emit(state.copyWith(isLoading: true, page: page));
        final photos =
            await _getPhotoDataList(state.albumData!.assetPath, page);
        final photoDataList = List.of(state.photoDataList);
        photoDataList.addAll(photos);
        emit(state.copyWith(
          isLoading: false,
          photoDataList: photoDataList,
          page: page,
        ));
        isLoading = false;
        break;
      case GalleryEvent.onTapShowAlbums:
        emit(state.copyWith(isShowAlbums: !state.isShowAlbums));
        break;
      case GalleryEvent.onTapAlbum:
        emit(state.copyWith(
          albumData: event.extra as AlbumData,
          isShowAlbums: false,
          photoDataList: [],
        ));
        add(BlocEvent(GalleryEvent.onLoadingImages, extra: 0));
        break;
      case GalleryEvent.onSelectImages:
        emit(state.copyWith(
          selectedPhotoDataList: event.extra as List<PhotoData>,
        ));
        break;
      case GalleryEvent.onNextPage:
        final page = event.extra as int;
        if (!isLoading) {
          isLoading = true;
          add(BlocEvent(GalleryEvent.onLoadingImages, extra: page + 1));
        }
        break;
      case GalleryEvent.onTapImage:
        final imageData = event.extra as PhotoData;
        final selectedList = List.of(state.selectedPhotoDataList);
        if (selectedList.contains(imageData)) {
          selectedList.remove(imageData);
        } else {
          selectedList.add(imageData);
        }
        emit(state.copyWith(selectedPhotoDataList: selectedList));
        break;
      case GalleryEvent.onTapSelect:
        context.pop(state.selectedPhotoDataList);
        break;
    }
  }

  Future<List<PhotoData>> _getPhotoDataList(AssetPathEntity path, page) async {

    final assets = await path.getAssetListRange(
      start: page * 100,
      end: page * 100 + 100,
    );

    final List<PhotoData> photoDataList = [];
    for (AssetEntity asset in assets) {
      final Uint8List? thumbnailData = await asset.thumbnailData;
      final photoData = PhotoData(
        thumbData: thumbnailData!,
        assetEntity: asset,
        hasLocation: asset.latitude != null &&
            asset.longitude != null &&
            asset.latitude! != 0 &&
            asset.longitude! != 0,
      );
      photoDataList.add(photoData);
    }
    return photoDataList;
  }

  Future<bool> _requestPermission() async {
    final permission = await PhotoManager.requestPermissionExtend();
    switch (permission) {
      case PermissionState.authorized:
        return true;
      case PermissionState.limited:
        return true;
      default:
        return false;
    }
  }

  Future<List<AlbumData>> _loadAlbums() async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: true,
      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(asc: false, type: OrderOptionType.createDate)
        ],
      ),
    );

    List<AlbumData> albumDataList = [];
    for (final album in albums) {
      final count = await album.assetCountAsync;

      if (count > 0) {
        final asset = await album.getAssetListPaged(page: 0, size: 1);
        final coverImage = await asset.first.thumbnailDataWithSize(
          const ThumbnailSize(300, 300),
        );
        final krName = koAlbums.containsKey(album.name)
            ? koAlbums[album.name]
            : album.name;
        albumDataList.add(
          AlbumData(
            id: album.id,
            name: album.name,
            krName: krName!,
            count: count,
            coverImage: coverImage,
            assetPath: album,
          ),
        );
      }
    }
    return albumDataList;
  }
}
