import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../../app/providers/app_providers.dart';

final dioProvider = Provider<Dio>((ref) {
  final appConfig = ref.watch(appConfigProvider);
  final talker = ref.watch(talkerProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: const {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),
  );

  ref.onDispose(() => dio.close(force: true));
  return dio;
});
