import 'package:dio/dio.dart';

import '../dtos/sign_in_request_dto.dart';
import '../dtos/sign_in_response_dto.dart';
import '../dtos/user_dto.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final Dio _dio;

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

    final data = response.data;
    if (data == null) {
      throw const FormatException('Response data is null');
    }

    return SignInResponseDto.fromJson(data);
  }

  Future<UserDto> getMe() async {
    final response = await _dio.get<Map<String, dynamic>>('/auth/me');

    final data = response.data;
    if (data == null) {
      throw const FormatException('Response data is null');
    }

    return UserDto.fromJson(data);
  }
}
