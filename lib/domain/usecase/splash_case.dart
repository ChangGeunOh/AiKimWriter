import 'package:aikimwriter/data/repository/repository.dart';

class SplashCase {
  final Repository _repository;

  SplashCase({
    required Repository repository,
  }) : _repository = repository;

  Future<bool> getShowPermission() {
    return _repository.getShowPermission();
  }

  Future<void> setShowPermission(bool showPermission) {
    return _repository.setShowPermission(showPermission);
  }
}
