import 'package:aikimwriter/common/const/color.dart';
import 'package:aikimwriter/domain/bloc/bloc_scaffold.dart';
import 'package:aikimwriter/presentation/screens/view/bloc/view_bloc.dart';
import 'package:aikimwriter/presentation/screens/view/bloc/view_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfx/pdfx.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/model/main/story_data.dart';
import '../main/widget/story_dialog.dart';

class ViewScreen extends StatefulWidget {
  final StoryData storyData;

  static String get routeName => 'view';

  const ViewScreen({
    super.key,
    required this.storyData,
  });

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  final PageController _pageController = PageController();
  late PdfController _pdfController;
  int _page = 1;

  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openFile(widget.storyData.pdfPath),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocScaffold<ViewBloc, ViewState>(
        backgroundColor: const Color(0xffE5E5E5),
        create: (context) => ViewBloc(
              context,
              ViewState(storyData: widget.storyData),
            ),
        appBar: AppBar(
          backgroundColor: const Color(0xffE5E5E5),
          iconTheme: const IconThemeData(
            color: Colors.black54,
          ),
          title: Text(
            widget.storyData.bookTitle,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                print('share');
                showDialog(context: context, builder: (context) {
                  return StoryDialog(
                    storyData: widget.storyData,
                    onRemove: (storyData) {
                      context.pop(storyData);
                    },
                  );
                });
              },
              icon: const Icon(
                Icons.ios_share,
              ),
            ),
          ],
        ),
        builder: (context, bloc, state) {
          return Stack(
            children: [
              PdfView(
                controller: _pdfController,
                onPageChanged: (page) {
                  _page = page;
                },
              ),
              Positioned(
                bottom: 32,
                right: 0,
                left: 0,
                child: Center(
                  child: PdfPageNumber(
                    controller: _pdfController,
                    // When `loadingState != PdfLoadingState.success`  `pagesCount` equals null_
                    builder: (_, state, loadingState, pagesCount) => Container(
                      alignment: Alignment.center,
                      child: Text(
                        '$_page/${pagesCount ?? 0}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
          // return Stack(
          //   children: [
          //     PageView.builder(
          //       controller: _pageController,
          //       itemBuilder: (BuildContext context, int index) {
          //         return Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Image.asset(
          //             widget.imageList[index],
          //             fit: BoxFit.contain,
          //           ),
          //         );
          //       },
          //       itemCount: widget.imageList.length,
          //     ),
          //     Positioned(
          //       bottom: 24,
          //       right: 0,
          //       left: 0,
          //       child: Center(
          //         child: SmoothPageIndicator(
          //           controller: _pageController,
          //           count: widget.imageList.length,
          //           effect: const WormEffect(
          //             dotColor: Colors.grey,
          //             activeDotColor: primaryColor,
          //             dotHeight: 6,
          //             spacing: 4,
          //             dotWidth: 6,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // );
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
