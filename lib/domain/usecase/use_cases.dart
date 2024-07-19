import 'package:aikimwriter/domain/usecase/splash_case.dart';

import 'gallery_case.dart';

class UseCases {
  final SplashCase splashCase;
  final GalleryCase galleryCase;

  UseCases({
    required this.splashCase,
    required this.galleryCase,
  });
}
