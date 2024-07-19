import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/network.dart';
import '../../domain/repository/network_source.dart';

part 'network_source_impl.g.dart';

@RestApi()
abstract class NetworkSourceImpl extends NetworkSource {
  factory NetworkSourceImpl(Dio dio, {String baseUrl}) = _NetworkSourceImpl;

  @override
  @GET(kPathGoogleGeocode)
  Future<String> getAddress({
    @Path('latitude')
    required double latitude,
    @Path('longitude')
    required double longitude,
    @Path('apiKey')
    required String apiKey,
  });
}
