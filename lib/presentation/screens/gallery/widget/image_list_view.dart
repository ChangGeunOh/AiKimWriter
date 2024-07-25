import 'package:aikimwriter/domain/model/gallery/photo_data.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/gallery/image_data.dart';
import 'image_grid_view.dart';
import 'selected_image_view.dart';

class ImageListView extends StatelessWidget {
  final List<PhotoData> imageDataList;
  final List<PhotoData> selectedImageList;
  final Function(PhotoData) onTap;
  final VoidCallback onNextPage;

  const ImageListView({
    super.key,
    required this.imageDataList,
    required this.selectedImageList,
    required this.onTap,
    required this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    if (imageDataList.isEmpty) {
      return const Center(
        child: Text('앨범에 사진이 없습니다.'),
      );
    }
    return Column(
      children: [
        if (selectedImageList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 16.0,
            ),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: SelectedImageView(
                selectedList: selectedImageList,
                onTap: onTap,
              ),
            ),
          ),
        Expanded(
          child: ImageGridView(
            imageDataList: imageDataList,
            onTap: onTap,
            selectedList: selectedImageList,
            onNextPage: onNextPage,
          ),
        ),
      ],
    );
  }
}