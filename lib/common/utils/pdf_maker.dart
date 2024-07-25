import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart' as pdfx;

class Paragraph {
  final Uint8List? image;
  final String? imagePath;
  final String? subject;
  final String? date;
  final String? text;

  Paragraph({
    this.image,
    this.imagePath,
    this.subject,
    this.date,
    this.text,
  });

  Paragraph copyWith({
    Uint8List? image,
    String? imagePath,
    String? subject,
    String? date,
    String? text,
  }) {
    return Paragraph(
      image: image ?? this.image,
      imagePath: imagePath ?? this.imagePath,
      subject: subject ?? this.subject,
      date: date ?? this.date,
      text: text ?? this.text,
    );
  }
}

class PdfData {
  final String pdfPath;
  final String coverImagePath;

  PdfData({
    required this.pdfPath,
    required this.coverImagePath,
  });
}

class PdfMaker {
  final String id;
  final String title;
  final String author;
  final String term;
  final Uint8List? coverImage;
  final String? coverImagePath;
  final List<Paragraph> paragraphs;
  final String travelPlace;

  late pw.ThemeData theme;
  late pw.Document pdf;

  PdfMaker._({
    String? id,
    this.title = '',
    this.author = '박시현',
    this.term = '2024.02.11~02.15',
    this.coverImage,
    this.coverImagePath,
    this.paragraphs = const [],
    required this.travelPlace,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  static Future<PdfMaker> create({
    required String title,
    required String author,
    Uint8List? coverImage,
    String? coverImagePath,
    required String term,
    List<Paragraph> paragraphs = const [],
    required String travelPlace,
  }) async {
    final pdfMaker = PdfMaker._(
      title: title,
      author: author,
      coverImage: coverImage,
      coverImagePath: coverImagePath,
      paragraphs: paragraphs,
      term: term,
      travelPlace: travelPlace,
    );
    await pdfMaker._init();
    return pdfMaker;
  }

  Future<void> _init() async {
    final sansKrBold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSansKR-Bold.ttf'),
    );
    final sansKrRegular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSansKR-Regular.ttf'),
    );

    theme = pw.ThemeData(
      defaultTextStyle: pw.TextStyle(
        font: sansKrRegular,
        fontSize: 12,
        color: PdfColors.black,
      ),
      header0: pw.TextStyle(
        font: sansKrBold,
        fontSize: 75,
        color: PdfColors.white,
      ),
      header1: pw.TextStyle(
        font: sansKrBold,
        fontSize: 20,
        color: PdfColors.white,
      ),
      header2: pw.TextStyle(
        font: sansKrBold,
        fontSize: 32,
        color: PdfColors.black,
      ),
      header3: pw.TextStyle(
        font: sansKrBold,
        fontSize: 14,
        color: PdfColors.black,
      ),
      header4: pw.TextStyle(
        font: sansKrBold,
        fontSize: 24,
        color: PdfColors.black,
      ),
    );

    pdf = pw.Document(
      theme: theme,
      title: title,
    );
  }

  List<List<Paragraph>> chunk(List<Paragraph> list, int size) {
    List<List<Paragraph>> chunks = [];
    for (int i = 0; i < list.length; i += size) {
      int end = (i + size < list.length) ? i + size : list.length;
      chunks.add(list.sublist(i, end));
    }
    return chunks;
  }

  Future<PdfData> makePdfFile() async {
    pdf.addPage(await _makeCoverPage()); // Page
    if (paragraphs.isNotEmpty) {
      final paragraphsPerPage = chunk(paragraphs, 2);

      for (int i = 0; i < paragraphsPerPage.length; i++) {
        pdf.addPage(await _makeInnerPage(paragraphsPerPage[i], i)); // Page
      }
    }

    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/$id.pdf");
    await file.writeAsBytes(await pdf.save());

    final coverImagePath = await getCoverImage(file.path);

    return PdfData(
      pdfPath: file.path,
      coverImagePath: coverImagePath,
    );
  }

  Future<String> getCoverImage(String pdfFilePath) async {
    final document = await pdfx.PdfDocument.openFile(pdfFilePath);
    final page = await document.getPage(1);
    final pageImage = await page.render(
      width: page.width,
      height: page.height,
      format: pdfx.PdfPageImageFormat.png,
    );
    final imageFile = File('${(await getApplicationDocumentsDirectory()).path}/$id.png');
    await imageFile.writeAsBytes(pageImage!.bytes);
    return imageFile.path;
  }

  pw.Widget verticalText(
    String text, {
    pw.TextStyle? textStyle,
    double lineSpace = 0,
  }) {
    final List<pw.Widget> letters = text.split('').map((char) {
      return pw.Padding(
        padding: pw.EdgeInsets.only(top: lineSpace),
        child: pw.Text(char, style: textStyle),
      );
    }).toList();

    // Return a Column with the text widgets
    return pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      children: letters,
    );
  }

  Future<pw.Page> _makeCoverPage() async {
    final Uint8List imageBytes;
    if (coverImagePath != null) {
      final img = await rootBundle.load(coverImagePath!);
      imageBytes = img.buffer.asUint8List();
    } else {
      imageBytes = coverImage!;
    }

    final titleSplit = title.split(' ').reversed.toList();
    final titleWidget = titleSplit
        .map(
          (e) => pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _verticalDivider(),
              verticalText(
                e,
                textStyle: theme.header0,
                lineSpace: -20,
              ),
            ],
          ),
        )
        .toList();
    final maxString = titleSplit.reduce(
        (value, element) => value.length > element.length ? value : element);
    return pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(0),
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Image(
                pw.MemoryImage(imageBytes),
                width: PdfPageFormat.a4.width,
                height: PdfPageFormat.a4.height,
                fit: pw.BoxFit.fill,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  vertical: 60,
                  horizontal: 30,
                ),
                child: pw.SizedBox(
                  height: maxString.length * 89,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      pw.Spacer(),
                      ...titleWidget,
                      _verticalDivider(),
                      verticalText(
                        '$author지음',
                        textStyle: theme.header1.copyWith(fontSize: 20),
                        lineSpace: -4,
                      ),
                    ],
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: pw.Text(
                  term,
                  style: theme.header1.copyWith(fontSize: 24),
                ),
              ),
            ],
          );
        });
  }

  pw.Widget _verticalDivider() {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10),
      child: pw.Container(
        width: 1,
        color: PdfColors.white,
      ),
    );
  }

  Future<pw.Page> _makeInnerPage(
    List<Paragraph> paragraphs,
    int page,
  ) async {
    final firstParagraph = paragraphs.first;
    final lastParagraph = paragraphs.length > 1 ? paragraphs.last : null;

    final pageTop = await _makeParagraph(paragraphs.first, false);
    final pageBottom = paragraphs.length > 1
        ? await _makeParagraph(paragraphs.last, true)
        : pw.Padding(padding: pw.EdgeInsets.zero);

    return pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(0),
        buildBackground: (context) {
          return pw.Container(
            color: const PdfColor.fromInt(0xFFE5E5E5),
          );
        },
      ),
      build: (pw.Context context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 40,
          ),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                travelPlace,
                style: theme.header2,
              ),
              pw.Divider(height: 25),
              pw.SizedBox(height: 20),
              if (firstParagraph.subject != null || firstParagraph.date != null)
                _makeParagraphSubject(
                  firstParagraph.date,
                  firstParagraph.subject,
                ),
              pw.Expanded(child: pageTop),
              pw.SizedBox(height: 25),
              if (lastParagraph != null)
                _makeParagraphSubject(
                  lastParagraph.date,
                  lastParagraph.subject,
                ),
              pw.Expanded(child: pageBottom),
            ],
          ),
        );
      },
    );
  }

  pw.Widget _makeParagraphSubject(String? date, String? subject) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        if (date != null)
          pw.Text(
            date,
            style: theme.header3,
          ),
        pw.SizedBox(height: 5),
        if (subject != null)
          pw.Text(
            subject,
            style: theme.header4,
          ),
        pw.SizedBox(height: 20),
      ],
    );
  }

  Future<pw.Widget> _makeParagraph(Paragraph paragraph, bool isReverse) async {
    Uint8List imageBytes;
    if (paragraph.imagePath != null) {
      final img = await rootBundle.load(paragraph.imagePath!);
      imageBytes = img.buffer.asUint8List();
    } else {
      imageBytes = paragraph.image!;
    }

    final imageWidget = pw.Image(
      pw.MemoryImage(imageBytes),
      fit: pw.BoxFit.contain,
    );

    final textWidget = pw.Text(
      paragraph.text!,
      style: theme.defaultTextStyle,
    );

    final leftWidget = isReverse ? imageWidget : textWidget;
    final rightWidget = isReverse ? textWidget : imageWidget;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: leftWidget,
              ),
              pw.SizedBox(width: 25),
              pw.Expanded(
                child: rightWidget,
              ),
            ],
          ),
        )
      ],
    );
  }
}
