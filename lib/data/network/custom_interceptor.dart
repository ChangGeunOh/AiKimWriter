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

}
