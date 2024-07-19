import 'dart:convert';

import 'package:photo_manager/photo_manager.dart';

import '../../common/const/const.dart';
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
      // if (weatherAddressData != null) {
      //   address = weatherAddressData.address;
      //   weather = weatherAddressData.weather;
      // } else if (asset.latitude != null &&
      //     asset.longitude != null &&
      //     asset.latitude! != 0 &&
      //     asset.longitude! != 0) {
      // address = await _networkSource.getAddress(
      //   latitude: asset.latitude!,
      //   longitude: asset.longitude!,
      //   apiKey: keyGoogleApi,
      // );
      // weather = '맑음';
      //
      // final weatherAddressData = WeatherAddressData(
      //   id: asset.id,
      //   weather: weather,
      //   address: address,
      // );
      //
      // _dataStoreSource.setWeatherAddressData(weatherAddressData);

      // }

      String filePath = '';
      // try {
      //   final originFile = await asset.originFile;
      //   filePath = originFile?.path ?? '';
      // } catch (e) {
      //   print('error: $e');
      // }

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
    print('addressData>${addressData?.toJson()}');
    if (addressData != null) {
      return addressData.address;
    }
    final response = await _networkSource.getAddress(
      latitude: latitude,
      longitude: longitude,
      apiKey: keyGoogleApi,
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
}
