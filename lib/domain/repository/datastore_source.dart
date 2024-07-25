import 'package:aikimwriter/domain/model/gallery/weather_address_data.dart';
import 'package:aikimwriter/domain/model/main/story_data.dart';

abstract class DataStoreSource {
  Future<void> setShowPermission(bool showPermission);

  Future<bool> getShowPermission();

  Future<void> setWeatherAddressData(WeatherAddressData weatherAddressData);
  Future<WeatherAddressData?> getWeatherAddressData(String id);

  Future<void> saveStoryData(StoryData storyData);
  Future<List<StoryData>> loadStoryDataList();

  Future<void> removeStoryData(StoryData storyData);
}
