import 'package:dio/dio.dart';

import '../../domain/entities/social_provider.dart';
import '../dtos/sign_in_request_dto.dart';
import '../dtos/sign_in_response_dto.dart';
import '../dtos/social_auth_request_dto.dart';
import '../dtos/user_dto.dart';
import 'auth_remote_data_source.dart';

class DioAuthRemoteDataSource implements AuthRemoteDataSource {
  DioAuthRemoteDataSource(this._dio);

  final Dio _dio;

  @override
  Future<void> verifyBusinessNumber({required String businessNumber}) async {
    await _dio.post<void>(
      '/auth/business-number/verify',
      data: <String, dynamic>{'businessNumber': businessNumber},
    );
  }

  @override
  Future<SignInResponseDto> signIn({
    required String businessNumber,
    required String password,
  }) async {
    final requestDto = SignInRequestDto(
      businessNumber: businessNumber,
      password: password,
    );

    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/sign-in',
      data: requestDto.toJson(),
    );

    return _parseSignInResponse(response.data);
  }

  @override
  Future<SignInResponseDto> signInWithSocial({
    required SocialProvider provider,
    required String accessToken,
  }) async {
    final requestDto = SocialAuthRequestDto(accessToken: accessToken);

    final response = await _dio.post<Map<String, dynamic>>(
      provider.signInPath,
      data: requestDto.toJson(),
    );

    return _parseSignInResponse(response.data);
  }

  @override
  Future<SignInResponseDto> signUp({
    required String businessNumber,
    required String password,
  }) async {
    final requestDto = SignInRequestDto(
      businessNumber: businessNumber,
      password: password,
    );

    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/sign-up',
      data: requestDto.toJson(),
    );

    return _parseSignInResponse(response.data);
  }

  @override
  Future<void> linkSocialAccount({
    required SocialProvider provider,
    required String accessToken,
    required String appAccessToken,
  }) async {
    final requestDto = SocialAuthRequestDto(accessToken: accessToken);

    await _dio.post<void>(
      provider.linkPath,
      data: requestDto.toJson(),
      options: Options(headers: _authorizationHeaders(appAccessToken)),
    );
  }

  @override
  Future<UserDto> getMe({required String appAccessToken}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/auth/me',
      options: Options(headers: _authorizationHeaders(appAccessToken)),
    );

    final data = response.data;
    if (data == null) {
      throw const FormatException('Response data is null');
    }

    return UserDto.fromJson(data);
  }

  SignInResponseDto _parseSignInResponse(Map<String, dynamic>? data) {
    if (data == null) {
      throw const FormatException('Response data is null');
    }

    return SignInResponseDto.fromJson(data);
  }

  Map<String, String> _authorizationHeaders(String appAccessToken) {
    return <String, String>{'Authorization': 'Bearer $appAccessToken'};
  }
}
