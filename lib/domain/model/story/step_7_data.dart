class Step7Data {
  final String coverImage;
  final List<String> innerImageList;

  Step7Data({
    this.coverImage = 'assets/images/img_cover_sample.png',
    this.innerImageList = const ['assets/images/img_page_sample_01.png', 'assets/images/img_page_sample_02.png'],
  });

  get pageList => [coverImage, ...innerImageList];
}