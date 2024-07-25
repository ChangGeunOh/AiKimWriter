class Step7Data {
  final String coverImage;
  final String filePath;

  Step7Data({
    this.coverImage = '',
    this.filePath = '',
  });


  bool get isFilled => filePath.isNotEmpty;
}