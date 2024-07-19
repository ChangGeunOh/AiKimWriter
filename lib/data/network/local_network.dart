import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'custom_interceptor.dart';

class LocalNetwork {
  final CustomInterceptor customInterceptor;

  LocalNetwork(
    this.customInterceptor,
  );

  Dio get dio {
    final dio = Dio();
    dio.interceptors.add(customInterceptor);
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    dio.options.responseType = ResponseType.json;

    return dio;
  }

// static Dio get dio {
//   final dio = Dio();
//   dio.interceptors.add(CustomInterceptor());
//   dio.interceptors.add(
//     PrettyDioLogger(
//       requestHeader: true,
//       requestBody: true,
//       responseBody: false,
//       responseHeader: true,
//       error: true,r
//       compact: true,
//       maxWidth: 90,
//     ),
//   );
//   dio.options.responseType = ResponseType.json;
//
//   return dio;
// }
}
