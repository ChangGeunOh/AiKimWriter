import 'package:flutter/material.dart';

import '../../../../domain/model/story/book_type.dart';

class ImageTextListView extends StatefulWidget {
  final String title;
  final Function(BookType) onTapBookType;
  final BookType? bookType;
  final List<BookType> bookTypeList;

  const ImageTextListView({
    super.key,
    required this.title,
    required this.bookType,
    required this.onTapBookType,
    required this.bookTypeList,
  });

  @override
  State<ImageTextListView> createState() => _ImageTextListViewState();
}

class _ImageTextListViewState extends State<ImageTextListView> {

  BookType? _bookType;

  @override
  void initState() {
    _bookType = widget.bookType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
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
                final bookType = widget.bookTypeList[index];
                return SizedBox(
                  width: 84,
                  height: 114,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _bookType = bookType;
                              widget.onTapBookType(bookType);
                              setState(() {});
                            },
                            child: Opacity(
                              opacity: _bookType == bookType ? 1 : 0.2,
                              child: Image.asset(
                                bookType.imagePath,
                                fit: BoxFit.cover,
                                width: 84,
                                height: 114,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            bookType.type,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      if (_bookType == bookType)
                        Center(
                          child: Image.asset(
                            'assets/images/img_red_circle.png',
                            width: 70,
                            height: 100,
                          ),
                        ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
              itemCount: widget.bookTypeList.length,
            ),
          ),
        ],
      ),
    );
  }
}
