import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/common_failure.dart';
import '../../domain/entities/current_user.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../dtos/sign_in_response_dto.dart';
import '../mappers/auth_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const _duplicateBusinessNumberMessage = '이미 가입된 사업자번호입니다.';

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  AuthResultFuture<Unit> verifyBusinessNumber({
    required String businessNumber,
  }) {
    return TaskEither.tryCatch(() async {
      await _remoteDataSource.verifyBusinessNumber(
        businessNumber: businessNumber,
      );

      return unit;
    }, _mapError);
  }

  @override
  AuthResultFuture<CurrentUser> signIn({
    required String businessNumber,
    required String password,
  }) {
    return TaskEither.tryCatch(() async {
      final response = await _remoteDataSource.signIn(
        businessNumber: businessNumber,
        password: password,
      );

      return _persistSession(response);
    }, _mapError);
  }

  @override
  AuthResultFuture<CurrentUser> signUp({
    required String businessNumber,
    required String password,
  }) {
    return TaskEither.tryCatch(() async {
      final response = await _remoteDataSource.signUp(
        businessNumber: businessNumber,
        password: password,
      );

      return _persistSession(response);
    }, _mapError);
  }

  @override
  AuthResultFuture<CurrentUser?> restoreSession() {
    return TaskEither.tryCatch(() async {
      final accessToken = await _localDataSource.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        return null;
      }

      final userDto = await _remoteDataSource.getMe();
      return userDto.toEntity();
    }, _mapError);
  }

  @override
  AuthResultFuture<Unit> signOut() {
    return TaskEither.tryCatch(() async {
      await _localDataSource.clearTokens();
      return unit;
    }, _mapError);
  }

  AuthFailure _mapError(Object error, StackTrace stackTrace) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final path = error.requestOptions.path;
      final message = _extractMessage(error);

      if (statusCode == 401) {
        return const AuthFailure.unauthorized();
      }

      if (_isDuplicateBusinessNumberVerificationError(
        path: path,
        message: message,
      )) {
        return const AuthFailure.duplicateBusinessNumber();
      }

      if (path == '/auth/sign-in' && (statusCode == 400 || statusCode == 403)) {
        return const AuthFailure.invalidCredentials();
      }

      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return const AuthFailure.common(CommonFailure.network());
      }

      return AuthFailure.common(CommonFailure.server(message));
    }

    if (error is FormatException) {
      return AuthFailure.common(CommonFailure.unknown(error.message));
    }

    return AuthFailure.common(CommonFailure.unknown(error.toString()));
  }

  bool _isDuplicateBusinessNumberVerificationError({
    required String path,
    required String? message,
  }) {
    return path == '/auth/business-number/verify' &&
        message == _duplicateBusinessNumberMessage;
  }

  Future<CurrentUser> _persistSession(SignInResponseDto response) async {
    await _localDataSource.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );

    return response.user.toEntity();
  }

  String? _extractMessage(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }
    }

    if (data is Map) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }
    }

    return error.message;
  }
}
