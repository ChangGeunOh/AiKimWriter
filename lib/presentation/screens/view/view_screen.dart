import 'package:aikimwriter/common/const/color.dart';
import 'package:aikimwriter/domain/bloc/bloc_scaffold.dart';
import 'package:aikimwriter/presentation/screens/view/bloc/view_bloc.dart';
import 'package:aikimwriter/presentation/screens/view/bloc/view_state.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/model/main/story_data.dart';

class ViewScreen extends StatelessWidget {
  final StoryData storyData;

  static String get routeName => 'view';

  const ViewScreen({
    super.key,
    required this.storyData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocScaffold<ViewBloc, ViewState>(
        backgroundColor: const Color(0xffE5E5E5),
        create: (context) => ViewBloc(
              context,
              ViewState(storyData: storyData),
            ),
        appBar: AppBar(
          backgroundColor: const Color(0xffE5E5E5),
          iconTheme: const IconThemeData(
            color: Colors.black54,
          ),
          title: Text(storyData.bookTitle),
        ),
        builder: (context, bloc, state) {
          return CustomPageView(imageList: storyData.bookPageList);
        });
  }
}

class CustomPageView extends StatefulWidget {
  final List<String> imageList;

  const CustomPageView({
    super.key,
    required this.imageList,
  });

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                widget.imageList[index],
                fit: BoxFit.contain,
              ),
            );
          },
          itemCount: widget.imageList.length,
        ),
        Positioned(
          bottom: 24,
          right: 0,
          left: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.imageList.length,
              effect: const WormEffect(
                dotColor: Colors.grey,
                activeDotColor: primaryColor,
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
