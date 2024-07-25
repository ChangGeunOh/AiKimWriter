import 'dart:convert';
import 'package:aikimwriter/domain/model/main/story_data.dart';
import 'package:dio/dio.dart';
import 'package:exif/exif.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../common/utils/convert.dart';
import '../../domain/model/azure/image_summary_request.dart';
import '../../domain/model/gallery/image_data.dart';
import '../../domain/model/gallery/weather_address_data.dart';
import '../../domain/model/story/address_data.dart';
import '../../domain/repository/database_source.dart';
import '../../domain/repository/datastore_source.dart';
import '../../domain/repository/network_source.dart';

class Repository {
  final DatabaseSource _dataBaseSource;
  final DataStoreSource _dataStoreSource;
  final NetworkSource _networkSource;

  Repository({
    required DatabaseSource dataBaseSource,
    required DataStoreSource dataStoreSource,
    required NetworkSource networkSource,
  })  : _dataBaseSource = dataBaseSource,
        _dataStoreSource = dataStoreSource,
        _networkSource = networkSource;

  Future<bool> getShowPermission() {
    return _dataStoreSource.getShowPermission();
  }

  Future<void> setShowPermission(bool showPermission) {
    return _dataStoreSource.setShowPermission(showPermission);
  }

  Future<List<ImageData>> getImageDataList({
    required AssetPathEntity assetPath,
    required int page,
  }) async {
    print('---------->getImageDataList>$page');

    final assets = await assetPath.getAssetListRange(
        start: page * 100, end: page * 100 + 100);
    print('assets.length: ${assets.length}');
    final List<ImageData> imageDataList = [];

    for (var asset in assets) {
      final weatherAddressData =
          await _dataStoreSource.getWeatherAddressData(asset.id) ??
              WeatherAddressData(
                id: asset.id,
                weather: '',
                address: '',
              );
      final thumbData = await asset.thumbnailDataWithSize(
        const ThumbnailSize(400, 400),
      );

      print('imageThumbData: ${thumbData?.length}');
      final imageData = ImageData(
        id: asset.id,
        originalPath: '',
        address: weatherAddressData.address,
        thumbData: thumbData,
        latitude: asset.latitude,
        longitude: asset.longitude,
        dateTime: asset.createDateTime,
      );
      imageDataList.add(imageData);
    }
    return imageDataList;
  }

  Future<String> getAddress({
    required String imageId,
    required double latitude,
    required double longitude,
  }) async {
    final addressData = await _dataBaseSource.getAddressData(
      latitude: latitude,
      longitude: longitude,
    );
    // print('addressData>${addressData?.toJson()}');
    if (addressData != null) {
      return addressData.address;
    }
    final response = await _networkSource.getAddress(
      latitude: latitude,
      longitude: longitude,
      apiKey: dotenv.env['GOOGLE_API_KEY']!,
    );
    final data = jsonDecode(response);
    final formattedAddress = data['results'][0]['formatted_address'];
    final address = AddressData(
      imageId: imageId,
      latitude: latitude,
      longitude: longitude,
      address: formattedAddress,
      rawData: response,
    );
    await _dataBaseSource.insertAddressData(address);
    return formattedAddress;
  }

  Future<void> postImageSummary({
    required List<MultipartFile> files,
    required ImageSummaryRequest desc,
  }) async {
    print('-------------------->');
    print(jsonEncode(desc.toJson()));
    print('files: ${files.toString()}');
    print('<--------------------');
    // final formData = FormData.fromMap({
    //   'desc': desc.toJson(),
    // });
    test(files, desc);
    // await _networkSource.postSummaryImage(files: files, desc: jsonEncode(desc));
  }

  Future<void> saveStoryData(StoryData storyData) async {
    _dataStoreSource.saveStoryData(storyData);
  }

  Future<List<StoryData>> loadStoryDataList() {
    return _dataStoreSource.loadStoryDataList();
  }

  Future<void> removeStoryData(StoryData storyData) async {
    _dataStoreSource.removeStoryData(storyData);
  }

  Future<void> test(List<MultipartFile> files, ImageSummaryRequest desc) async {
//           '{"meta":{"theme":"나홀로 여행","vibe":"","days":"2145/2146","dataType":"image"},"datas":[{"fileName":"${files.first.filename}","date":"2024/02/13 21:59","vibe":"null ","location":{"lat":46.54750333333333,"lon":7.980951666666667,"address":"Jungfraujoch, 3801 Fieschertal, 스위스"},"weather":""},{"fileName":"${files.last.filename}","date":"2018/03/31 04:14","vibe":"null ","location":{"lat":37.76007833333333,"lon":-122.50956666666667,"address":"1401 Great Hwy, San Francisco, CA 94122 미국"},"weather":""}]}'
    var data = FormData.fromMap({
      'data': files,
      'desc': jsonEncode(desc.toJson()),
    });

    print(data.files.first.value.length);
    var dio = Dio();
    var response = await dio.request(
      'https://team10-api.azurewebsites.net/api/travel/summary/pictures/async?code=C79kRLGqSxxEmjdevTpETK7HlMUfR7cayozj_ltFUyWMAzFupHr1-A%3D%3D',
      options: Options(
        method: 'POST',
        headers: {'Content-Type': 'multipart/form-data'},
        followRedirects: false,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
