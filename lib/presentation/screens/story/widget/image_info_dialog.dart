import 'package:aikimwriter/common/const/const.dart';
import 'package:aikimwriter/presentation/screens/story/widget/list_item_list_view.dart';
import 'package:aikimwriter/presentation/screens/story/widget/date_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/model/gallery/image_data.dart';
import '../../../widgets/custom_text_field.dart';

class ImageInfoDialog extends StatefulWidget {
  final ImageData imageData;

  const ImageInfoDialog({
    super.key,
    required this.imageData,
  });

  @override
  State<ImageInfoDialog> createState() => _ImageInfoDialogState();
}

class _ImageInfoDialogState extends State<ImageInfoDialog> {
  late TextEditingController _locationController;
  late TextEditingController _memoController;
  late ImageData _imageData;

  @override
  void initState() {
    _locationController = TextEditingController(text: widget.imageData.address);
    _memoController = TextEditingController(text: widget.imageData.description);
    _imageData = widget.imageData;
    super.initState();
  }

  @override
  dispose() {
    _locationController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 62),
                CustomTextField(
                  text: _imageData.address,
                  onChanged: (value) {
                    _imageData = _imageData.copyWith(address: value);
                    setState(() {});
                  },
                  labelText: '여행 장소',
                  hintText: '여행 장소를 입력하세요.',
                ),
                const SizedBox(height: 16),
                DateTextField(
                  labelText: '촬영일자',
                  dateTime: widget.imageData.dateTime,
                  onChanged: (value) {
                    _imageData = _imageData.copyWith(dateTime: value);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                ListItemListView(
                  title: '날씨',
                  listItemDataList: weatherDataList,
                  onTapListItem: (item) {
                    _imageData = _imageData.copyWith(weatherData: item);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                ListItemListView(
                  title: '분위기',
                  listItemDataList: vibeDataList,
                  onTapListItem: (item) {
                    _imageData = _imageData.copyWith(vibeData: item);
                    setState(() {});
                  },
                ),
                // const SizedBox(height: 16),
                const SizedBox(height: 16),
                CustomTextField(
                  onChanged: (value) {
                    _imageData = _imageData.copyWith(description: value);
                    setState(() {});
                  },
                  labelText: 'Memo',
                  hintText: '사진 관련 메모를 입력하세요.',
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed:_imageData.isValidate ? () {
                    context.pop(_imageData);
                  } : null,
                  child: const Text('등록 하기'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        Positioned(
          top: -50,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            child:ClipOval(
              child: Image.memory(
                widget.imageData.thumbData!,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ));
  }
  // bool get enable => _locationController.text.isNotEmpty &&
}
