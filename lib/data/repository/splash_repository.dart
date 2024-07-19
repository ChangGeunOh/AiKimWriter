import '../../domain/repository/datastore_source.dart';
import '../../domain/repository/network_source.dart';

class SplashRepository {
  final DataStoreSource _dataStoreSource;
  final NetworkSource _networkSource;

  SplashRepository({
    required DataStoreSource dataStoreSource,
    required NetworkSource networkSource,
  })  : _dataStoreSource = dataStoreSource,
        _networkSource = networkSource;

  Future<bool> getShowPermission() {
    return _dataStoreSource.getShowPermission();
  }

  Future<void> setShowPermission(bool showPermission) {
    return _dataStoreSource.setShowPermission(showPermission);
  }
}
