import 'package:aikimwriter/domain/model/gallery/weather_address_data.dart';

abstract class DataStoreSource {
  Future<void> setShowPermission(bool showPermission);

  Future<bool> getShowPermission();

  Future<void> setWeatherAddressData(WeatherAddressData weatherAddressData);
  Future<WeatherAddressData?> getWeatherAddressData(String id);
}
