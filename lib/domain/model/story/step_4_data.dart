
import 'book_type.dart';

class Step4Data {
  final List<String> titleList;
  final String title;
  final String textStyle;
  final BookType? bookType;

  Step4Data({
    this.titleList = const [ '겨울 왕국', '설산과 축제의 나라', '설산의 마법','하늘아래 펼쳐진 스위스', '뜻밖의 축제', '장엄한 설산'],
    this.title = '',
    this.textStyle = '',
    this.bookType,
  });

  Step4Data copyWith({
    List<String>? titleList,
    String? title,
    String? textStyle,
    BookType? bookType,
  }) {
    return Step4Data(
      titleList: titleList ?? this.titleList,
      title: title ?? this.title,
      textStyle: textStyle ?? this.textStyle,
      bookType: bookType ?? this.bookType,
    );
  }

  bool get isFilled => title.isNotEmpty && textStyle.isNotEmpty && bookType != null;

  String get filledData => 'titleList: $titleList, title: $title, textType: $textStyle, bookType: $bookType';

}