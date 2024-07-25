import 'package:flutter/material.dart';

import '../../../../domain/model/gallery/image_data.dart';
import '../../../../domain/model/gallery/photo_data.dart';

class SelectedImageView extends StatelessWidget {
  final List<PhotoData> selectedList;
  final Function(PhotoData) onTap;

  const SelectedImageView({
    super.key,
    required this.selectedList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final PhotoData imageData = selectedList[index];
        return Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: SizedBox(
            width: 60,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Image.memory(
                    imageData.thumbData,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      onTap(imageData);
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: selectedList.length,
    );
  }
}