import 'dart:convert';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/network.dart';
import '../../domain/model/azure/image_summary_request.dart';
import '../../domain/model/azure/image_summary_response.dart';
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

  @override
  @POST(kPathSummaryImage)
  @MultiPart()
  Future<ImageSummaryResponse> postSummaryImage({
    @Part(name: 'data') required List<MultipartFile> files,
    @Part(name: 'desc') required String desc,
  });
}
