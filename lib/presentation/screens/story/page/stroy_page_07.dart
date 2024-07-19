import 'package:aikimwriter/domain/model/story/step_7_data.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../domain/model/story/story_label_data.dart';
import '../widget/story_title.dart';

class StoryPage07 extends StatefulWidget {
  final Step7Data step7data;
  final StoryLabelData storyLabelData;
  final Function(Step7Data) onChanged;
  final Function onTapDone;

  const StoryPage07({
    super.key,
    required this.step7data,
    required this.storyLabelData,
    required this.onChanged,
    required this.onTapDone,
  });

  @override
  State<StoryPage07> createState() => _StoryPage01State();
}

class _StoryPage01State extends State<StoryPage07> {
  late Step7Data _step7data;
  final ScrollController _scrollController = ScrollController();
  bool _isDone = false;

  @override
  void initState() {
    _step7data = widget.step7data;
    super.initState();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
    );
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
            child: Center(
              child: ImagePagerView(
                step7data: _step7data,
                isDone: _isDone,
                onEnd: (){
                  _isDone = true;
                  widget.onChanged(_step7data);
                  setState(() {});
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 32,
              left: 48.0,
              right: 48.0,
              bottom: 8.0,
            ),
            child: ElevatedButton(
              onPressed: _isDone ? (){
                widget.onChanged(_step7data);
                widget.onTapDone();
              }: null,
              child: const Text('책장에 보관할 께요.'),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePagerView extends StatefulWidget {
  final Step7Data step7data;
  final VoidCallback onEnd;
  final bool isDone;

  const ImagePagerView({
    super.key,
    required this.isDone,
    required this.step7data,
    required this.onEnd,
  });

  @override
  State<ImagePagerView> createState() => _ImagePagerViewState();
}

class _ImagePagerViewState extends State<ImagePagerView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageList = [
      widget.step7data.coverImage,
      ...widget.step7data.innerImageList
    ];
    final imageWidgetList = imageList
        .mapIndexed(
          (index, image) {
            if (index == 0 && !widget.isDone) {
              return CoverImageView(
                imagePath: image,
                onEnd: widget.onEnd,
              );
            } else {
              return Image.asset(
                image,
              );
            }
          },
        )
        .toList();
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: imageWidgetList,
        ),
        Positioned(
          bottom: 8,
          right: 0,
          left: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.isDone ? imageList.length : 1,
              effect: WormEffect(
                dotColor: Colors.grey[300]!,
                activeDotColor: Colors.grey,
                dotHeight: 6,
                spacing: 4,
                dotWidth: 6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CoverImageView extends StatefulWidget {
  final String imagePath;
  final VoidCallback onEnd;

  const CoverImageView({
    super.key,
    required this.imagePath,
    required this.onEnd,
  });

  @override
  State<CoverImageView> createState() => _CoverImageViewState();
}

class _CoverImageViewState extends State<CoverImageView> {
  double _opacity = 0.0;

  @override
  void initState() {
    _fadeIn();
    super.initState();
  }

  void _fadeIn() async {
    await Future.delayed(const Duration(milliseconds: 1000)); // Optional delay
    setState(() {
      _opacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(seconds: 3),
      onEnd: widget.onEnd,
      child: Image.asset(
        widget.imagePath, // Replace with your image URL or asset
      ),
    );
  }
}
