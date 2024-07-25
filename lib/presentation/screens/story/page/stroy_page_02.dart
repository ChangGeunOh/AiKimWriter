import 'dart:io';

import 'package:aikimwriter/domain/model/gallery/photo_data.dart';
import 'package:collection/collection.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../domain/model/gallery/image_data.dart';
import '../../../../domain/model/story/story_label_data.dart';
import '../../../../domain/usecase/use_cases.dart';
import '../../gallery/gallery_screen.dart';
import '../widget/image_info_dialog.dart';
import '../widget/story_image_add_item.dart';
import '../widget/story_image_item.dart';
import '../widget/story_title.dart';

class StoryPage02 extends StatefulWidget {
  final StoryLabelData storyLabelData;
  final Function(List<ImageData>) onImageList;
  final List<ImageData> imageList;

  const StoryPage02({
    super.key,
    required this.storyLabelData,
    required this.onImageList,
    required this.imageList,
  });

  @override
  State<StoryPage02> createState() => _StoryPage02State();
}

class _StoryPage02State extends State<StoryPage02> {
  final ScrollController _scrollController = ScrollController();
  final List<ImageData> _imageDataList = [];

  void _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    _imageDataList.addAll(widget.imageList);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoryTitle(
            iconPath: widget.storyLabelData.iconPath,
            description: widget.storyLabelData.description,
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.76),
                        delegate: SliverChildBuilderDelegate(
                          (sliverContext, index) {
                            if (index == 0) {
                              return StoryImageAddItem(onTap: () async {
                                _showGallery();
                              });
                            }
                            final imageData = _imageDataList[index - 1];
                            return StoryImageItem(
                              imageData: imageData,
                              onTap: () {
                                _showImageInfoDialog(imageData);
                              },
                            );
                          },
                          childCount: _imageDataList.length + 1,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: _imageDataList.length > 1 ? 32.0 : 170,
                            left: 24.0,
                            right: 24.0,
                            bottom: 8.0,
                          ),
                          child: ElevatedButton(
                            onPressed: _imageDataList.isNotEmpty
                                ? () {
                                    widget.onImageList(_imageDataList);
                                  }
                                : null,
                            child: const Text('부족한 정보 채워 주세요.'),
                          ),
                        ),
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }

  void _showImageInfoDialog(ImageData imageData) async {
    final data = await showDialog(
      context: context,
      builder: (context) => ImageInfoDialog(imageData: imageData),
    );
    if (data != null) {
      final index = _imageDataList.indexOf(imageData);
      _imageDataList[index] = data as ImageData;
      setState(() {});
    }

    // bloc.add(BlocEvent(StoryEvent.onUpdateImage, result));
  }

  void _showGallery() async {
    final List<PhotoData>? result =
        await context.pushNamed(GalleryScreen.routeName);
    if (result != null) {
      for (final photoData in result) {
        final notContain =
            _imageDataList.every((e) => e.id != photoData.assetEntity.id);
        if (notContain) {
          final originalFile = await photoData.assetEntity.originFile;
          final originalPath = originalFile?.path ?? '';
          final imageData = ImageData(
            id: photoData.assetEntity.id,
            thumbData: photoData.thumbData,
            dateTime: photoData.assetEntity.createDateTime,
            latitude: photoData.assetEntity.latitude,
            longitude: photoData.assetEntity.longitude,
            originalPath: originalPath,
          );
          _imageDataList.add(imageData);
          _fetchAddress(imageData);
        }
      }
      setState(() {});
      _scrollToBottom();
    }
  }

  void _fetchAddress(ImageData imageData) async {
    final useCases = context.read<UseCases>();
    DateTime? dateTime;
    if (imageData.originalPath.isNotEmpty) {
      final data = await readExifFromFile(File(imageData.originalPath));
      if (data.containsKey('EXIF DateTimeOriginal') ||
          data.containsKey('Image DateTime')) {
        final date = data.containsKey('EXIF DateTimeOriginal')
            ? data['EXIF DateTimeOriginal']
            : data['Image DateTime'];
        dateTime = DateFormat('yyyy:MM:dd HH:mm:ss').parse(date.toString());
      }
    }
    final address = await useCases.galleryCase.getAddress(
      imageId: imageData.id,
      latitude: imageData.latitude,
      longitude: imageData.longitude,
    );
    final index = _imageDataList.indexOf(imageData);
    _imageDataList[index] =
        imageData.copyWith(address: address, dateTime: dateTime);
    setState(() {});
  }
}
