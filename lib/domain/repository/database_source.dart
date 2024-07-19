import '../model/story/address_data.dart';

abstract class DatabaseSource {
  Future<AddressData?> getAddressData({
    required double latitude,
    required double longitude,
    double? radius = 10,
  });

  Future<int>  insertAddressData(AddressData address);
}
