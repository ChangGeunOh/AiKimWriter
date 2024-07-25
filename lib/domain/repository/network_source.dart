import 'package:dio/dio.dart';

import '../model/azure/image_summary_request.dart';
import '../model/azure/image_summary_response.dart';

abstract class NetworkSource {

  Future<String> getAddress({
    required double latitude,
    required double longitude,
    required String apiKey,
  });

  Future<ImageSummaryResponse> postSummaryImage({
    required List<MultipartFile> files,
    required String desc,
  });
}
