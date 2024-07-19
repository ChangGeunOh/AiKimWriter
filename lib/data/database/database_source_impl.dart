import 'package:aikimwriter/data/database/local_database.dart';
import 'package:aikimwriter/domain/model/story/address_data.dart';

import '../../domain/repository/database_source.dart';

class DatabaseSourceImpl implements DatabaseSource {
  final LocalDatabase localDatabase;

  DatabaseSourceImpl({
    required this.localDatabase,
  });

  @override
  Future<AddressData?> getAddressData({
    required double latitude,
    required double longitude,
    double? radius = 10,
  }) async {
    final db = await localDatabase.database;
    final result = await db.rawQuery('''
SELECT * FROM (
    SELECT *,
           (6371 * acos(cos(radians(?)) * cos(radians(latitude)) * cos(radians(longitude) - radians(?)) + sin(radians(?)) * sin(radians(latitude)))) AS distance
    FROM address_table
) 
WHERE distance <= ?
ORDER BY distance
LIMIT 1;
    ''', [latitude, longitude, latitude, radius]);

    if (result.isNotEmpty) {
      return AddressData.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<int> insertAddressData(AddressData address) async {
    final db = await localDatabase.database;
    return db.insert(tableAddress, address.toJson());
  }
}
