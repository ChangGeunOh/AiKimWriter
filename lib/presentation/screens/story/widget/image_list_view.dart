import 'package:flutter/material.dart';

import '../../../../domain/model/gallery/image_data.dart';

class ImageListView extends StatefulWidget {
  final String title;
  final List<ImageData> imageDataList;
  final Function(ImageData) onTapImageData;

  const ImageListView({
    super.key,
    required this.imageDataList,
    required this.title,
    required this.onTapImageData,
  });

  @override
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  ImageData? _imageData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 148,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final imageData = widget.imageDataList[index];
                return InkWell(
                  onTap: () {
                    _imageData = imageData;
                    widget.onTapImageData(imageData);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 84,
                    height: 114,
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: _imageData == imageData ? 1 : 0.2,
                          child: Image.memory(
                            imageData.thumbData!,
                            fit: BoxFit.cover,
                            width: 84,
                            height: 114,
                          ),
                        ),
                        if (_imageData == imageData)
                          Center(
                            child: Image.asset(
                              'assets/images/img_red_circle.png',
                              width: 70,
                              height: 100,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
              itemCount: widget.imageDataList.length,
            ),
          ),
        ],
      ),
    );
  }
}
