import 'package:flutter/material.dart';

import '../../../domain/bloc/bloc_event.dart';
import '../../../domain/bloc/bloc_scaffold.dart';
import 'bloc/gallery_bloc.dart';
import 'bloc/gallery_event.dart';
import 'bloc/gallery_state.dart';
import 'widget/album_list_view.dart';
import 'widget/image_list_view.dart';

class GalleryScreen extends StatelessWidget {
  static String get routeName => "gallery";

  const GalleryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocScaffold<GalleryBloc, GalleryState>(
      create: (context) => GalleryBloc(
        context,
        GalleryState(),
      ),
      appBarBuilder: (context, bloc, state) {
        final title = state.albumData?.krName ?? '최근 항목';
        return AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: GestureDetector(
            onTap: () {
              bloc.add(BlocEvent(GalleryEvent.onTapShowAlbums));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(state.isShowAlbums
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
              ],
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            TextButton(
              child: Row(
                children: [
                  if (state.selectedImageDataList.isNotEmpty)
                    Text(
                      '${state.selectedImageDataList.length}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  const SizedBox(width: 4),
                  Text(
                    '선택',
                    style: TextStyle(
                      color: state.selectedImageDataList.isNotEmpty
                          ? Colors.black
                          : Colors.grey[300],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                bloc.add(BlocEvent(GalleryEvent.onTapSelect));
              },
            ),
          ],
        );
      },
      builder: (context, bloc, state) {
        if (state.isShowAlbums) {
          return AlbumListView(
              albumDataList: state.albumDataList,
              onTap: (albumData) {
                bloc.add(BlocEvent(GalleryEvent.onTapAlbum, extra: albumData));
              });
        }
        print('state.imageDataList: ${state.imageDataList.length}');
        return Stack(
          children: [
            ImageListView(
              imageDataList: state.imageDataList,
              onTap: (imageData) {
                bloc.add(BlocEvent(
                  GalleryEvent.onTapImage,
                  extra: imageData,
                ));
              },
              selectedImageList: state.selectedImageDataList,
              onNextPage: () {
                bloc.add(BlocEvent(
                  GalleryEvent.onNextPage,
                  extra: state.page,
                ));
              },
            ),
            if (state.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}




