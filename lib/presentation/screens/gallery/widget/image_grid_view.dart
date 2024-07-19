import 'package:flutter/material.dart';

import '../../../../domain/model/gallery/image_data.dart';


class ImageGridView extends StatefulWidget {
  final List<ImageData> imageDataList;
  final List<ImageData> selectedList;
  final Function(ImageData) onTap;
  final VoidCallback onNextPage;

  const ImageGridView({
    super.key,
    required this.imageDataList,
    required this.selectedList,
    required this.onTap,
    required this.onNextPage,
  });

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent * 0.8) {
        widget.onNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        final imageData = widget.imageDataList[index];
        final position = widget.selectedList.indexOf(imageData) + 1;
        return InkWell(
          onTap: () {
            widget.onTap(imageData);
          },
          child: ImageGridItem(
            imageData: imageData,
            index: position,
          ),
        );
      },
      itemCount: widget.imageDataList.length,
    );
  }
}

class ImageGridItem extends StatelessWidget {
  final int index;
  final ImageData imageData;

  const ImageGridItem({
    super.key,
    required this.imageData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: index <= 0 ? Colors.transparent : Colors.red,
          width: index <= 0 ? 0 : 4,
        ),
      ),
      child: Stack(
        children: [
          Image.memory(
            imageData.thumbData!,
            fit: BoxFit.cover,
            width: size.width,
            height: size.height,
          ),
          Positioned(
            top: 4,
            right: 4,
            child: _getBadge(),
          ),
          if (imageData.hasLocation)
            const Positioned(
              bottom: 6,
              left: 4,
              child: Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }

  Widget _getBadge() {
    if (index == 0) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
              width: 2,
            )),
      );
    }

    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
