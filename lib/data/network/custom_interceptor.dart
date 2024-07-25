import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../domain/repository/datastore_source.dart';

class CustomInterceptor extends Interceptor {
  final DataStoreSource dataStoreSource;
  final BuildContext context;

  CustomInterceptor({
    required this.context,
    required this.dataStoreSource,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('---------------------------------');
    print('Request Method: ${options.method}');
    print('Request Path: ${options.path}');
    print('Request Headers: ${options.headers}');
    print('Request Data: ${options.data}');
    print('---------------------------------');
    return handler.next(options); // continue
  }
}
