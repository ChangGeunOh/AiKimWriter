import 'package:aikimwriter/domain/model/gallery/weather_address_data.dart';

import '../../domain/repository/datastore_source.dart';
import 'local_data_store.dart';

const keyShowPermission = 'show_permission';

class DataStoreSourceImpl implements DataStoreSource {
  final LocalDataStore _dataStore;

  DataStoreSourceImpl({
    required LocalDataStore dataStore,
  }) : _dataStore = dataStore;

  @override
  Future<bool> getShowPermission() async {
    return await _dataStore.getBool(keyShowPermission);
  }

  @override
  Future<void> setShowPermission(bool showPermission) async {
    _dataStore.setBool(keyShowPermission, showPermission);
  }

  @override
  Future<WeatherAddressData?> getWeatherAddressData(String id) async {
    final key = 'weather_address_data_$id';
    final data = await _dataStore.getData(key);
    return data != null ? WeatherAddressData.fromJson(data) : null;
  }

  @override
  Future<void> setWeatherAddressData(WeatherAddressData weatherAddressData) async {
    final key = 'weather_address_data_${weatherAddressData.id}';
    _dataStore.setData(key, weatherAddressData);
  }

}


