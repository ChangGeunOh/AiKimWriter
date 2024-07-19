class Step6Data {
  final String coverImage;
  final String innerImage;

  Step6Data({
    this.coverImage = '',
    this.innerImage = '',
  });

  Step6Data copyWith({
    String? coverImage,
    String? innerImage,
  }) {
    return Step6Data(
      coverImage: coverImage ?? this.coverImage,
      innerImage: innerImage ?? this.innerImage,
    );
  }

  bool get isValidate => coverImage.isNotEmpty && innerImage.isNotEmpty;
}