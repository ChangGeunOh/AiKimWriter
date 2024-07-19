import 'package:flutter/material.dart';

class CoverListView extends StatefulWidget {
  final String title;
  final String coverImage;
  final List<String> coverImageList;
  final Function(String) onTapCoverImage;

  const CoverListView({
    super.key,
    required this.title,
    required this.coverImage,
    required this.coverImageList,
    required this.onTapCoverImage,
  });

  @override
  State<CoverListView> createState() => _CoverListViewState();
}

class _CoverListViewState extends State<CoverListView> {
  late String _coverImage;

  @override
  void initState() {
    _coverImage = widget.coverImage;
    super.initState();
  }

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
                final coverImage = widget.coverImageList[index];
                return InkWell(
                  onTap: () {
                    _coverImage = coverImage;
                    widget.onTapCoverImage(coverImage);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 84,
                    height: 114,
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: _coverImage == coverImage ? 1 : 0.2,
                          child: Image.asset(
                            coverImage,
                            fit: BoxFit.cover,
                            width: 84,
                            height: 114,
                          ),
                        ),
                        if (_coverImage == coverImage)
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
              itemCount: widget.coverImageList.length,
            ),
          ),
        ],
      ),
    );
  }
}
