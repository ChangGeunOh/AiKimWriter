import 'package:aikimwriter/domain/model/gallery/weather_address_data.dart';

import '../../domain/model/main/story_data.dart';
import '../../domain/repository/datastore_source.dart';
import 'local_data_store.dart';

const keyShowPermission = 'show_permission';
const keyStoryDataList = 'story_data_list';

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
  Future<void> setWeatherAddressData(
      WeatherAddressData weatherAddressData) async {
    final key = 'weather_address_data_${weatherAddressData.id}';
    _dataStore.setData(key, weatherAddressData);
  }

  @override
  Future<void> saveStoryData(StoryData storyData) async {
    final list = await loadStoryDataList();
    list.add(storyData);
    _dataStore.setData(keyStoryDataList, list);
  }

  @override
  Future<List<StoryData>> loadStoryDataList() async {
    final data = await _dataStore.getData(keyStoryDataList);
    if (data == null) {
      return [];
    }
    return List<StoryData>.from(data.map((e) => StoryData.fromJson(e)));
  }

  @override
  Future<void> removeStoryData(StoryData storyData) async {
    final list = await loadStoryDataList();
    print('------list>${list.length}');
    list.removeWhere((e) => e.id == storyData.id);
    print('------list>${list.length}');
    _dataStore.setData(keyStoryDataList, list);
  }
}


//   @override
//   Future<List<MapSearchSuggestionData>> getMapSearchSuggestionList() async {
//     final data = await _dataStore.getData(keyMapSearchSuggestionList);
//     print('data>$data');
//     if (data == null) {
//       return [];
//     }
//     final list = List<MapSearchSuggestionData>.from(
//         data.map((e) => MapSearchSuggestionData.fromJson(e)));
//     list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
//     return list;
//   }
