import 'package:aikimwriter/common/const/const.dart';
import 'package:aikimwriter/common/utils/extension.dart';
import 'package:aikimwriter/common/utils/pdf_maker.dart';
import 'package:aikimwriter/domain/model/story/step_7_data.dart';
import 'package:aikimwriter/presentation/screens/story/bloc/story_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdfx/pdfx.dart';

import '../../../../domain/model/story/story_label_data.dart';
import '../widget/story_title.dart';

class StoryPage07 extends StatefulWidget {
  final StoryState state;
  final Step7Data step7data;
  final StoryLabelData storyLabelData;
  final Function(Step7Data) onChanged;
  final Function onTapDone;

  const StoryPage07({
    super.key,
    required this.state,
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
  PdfData? _pdfData;

  @override
  void initState() {
    _step7data = widget.step7data;
    _makePdf();
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
              child: Center(
                child: _pdfData == null
                    ? const CircularProgressIndicator()
                    : StoryPdfView(pdfPath: _pdfData!.pdfPath),
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
              onPressed: _pdfData != null
                  ? () {
                      widget.onTapDone();
                    }
                  : null,
              child: const Text('책장에 보관할 께요.'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePdf() async {
    final storyList = widget.state.step5Data.story.split('\n\n');
    final List<Paragraph> paragraphs = [];

    for (final story in storyList) {

      final splitText = story.split('\n');
      final description = splitText.sublist(1).join('\n');

      final firstLine = splitText.first.split('-');
      final dateString = firstLine.first.split('(').first.trim();
      DateFormat dateFormat = DateFormat('yyyy년 M월 d일');

      final date = dateFormat.parse(dateString);
      final subject = firstLine.last;

      paragraphs.add(Paragraph(
        text: description,
        date: dateString.trim(),
        subject: subject,
      ));
    }

    final paragraphList = widget.state.imageDataList.map((e) {
      final date = e.dateTime.toDateString(format: 'yyyy년 M월 d일');
      final paragraph = paragraphs.firstWhereOrNull((element) => element.date!.contains(date));
      if (paragraph != null) {
        return paragraph.copyWith(
          image: e.thumbData!,
          imagePath: e.originalPath,
        );
      }

      return Paragraph(
        date: e.dateTime.toDateString(format: 'yyyy년 M월 d일 (E)'),
        text: paragraphs.last.text,
        image: e.thumbData!,
        imagePath: e.originalPath,
      );
    }).toList();

    paragraphList.sort((a, b) => a.date!.compareTo(b.date!));
    final lastParagraphs = paragraphList.mapIndexed((index, element) {
      if (index == 0) return element;
      final beforeElement = paragraphList[index - 1];
      if (element.date == beforeElement.date) {
            return element.copyWith(subject: '', date: '');
      }
      return element;
    }).toList();

    final pdf = await PdfMaker.create(
      title: widget.state.step4Data.title,
      coverImage: widget.state.step3Data.imageData!.thumbData!,
      coverImagePath: widget.state.step3Data.imageData!.originalPath,
      paragraphs: lastParagraphs,
      author: '박시현',
      travelPlace: widget.state.step3Data.travelPlace,
      term: widget.state.step3Data.dateTimeRange?.toDateRangeString() ?? '20024//02/11 ~ 02/13',
    );

    _pdfData = await pdf.makePdfFile();
    final step7data = Step7Data(
      filePath: _pdfData!.pdfPath,
      coverImage: _pdfData!.coverImagePath,
    );
    widget.onChanged(step7data);
    setState(() {});
  }
}

class StoryPdfView extends StatefulWidget {
  final String pdfPath;

  const StoryPdfView({
    super.key,
    required this.pdfPath,
  });

  @override
  State<StoryPdfView> createState() => _StoryPdfViewState();
}

class _StoryPdfViewState extends State<StoryPdfView> {
  late PdfController _pdfController;
  int _page = 0;

  @override
  void initState() {
    _pdfController =
        PdfController(document: PdfDocument.openFile(widget.pdfPath));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PdfView(
          controller: _pdfController,
          onPageChanged: (page) {
            _page = page;
            setState(() {});
          },
        ),
        Positioned(
          bottom: 8,
          right: 0,
          left: 0,
          child: Center(
            child: PdfPageNumber(
              controller: _pdfController,
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
  }
}
