import 'package:aikimwriter/domain/usecase/splash_case.dart';

import 'gallery_case.dart';
import 'story_case.dart';

class UseCases {
  final SplashCase splashCase;
  final GalleryCase galleryCase;
  final StoryCase storyCase;

  UseCases({
    required this.splashCase,
    required this.galleryCase,
    required this.storyCase,
  });
}
