import '../../../../core/errors/common_failure.dart';
import '../../domain/failures/auth_failure.dart';

String authFailureMessage(AuthFailure failure) {
  return switch (failure) {
    InvalidCredentials() => '입력한 정보를 다시 확인해주세요.',
    Unauthorized() => '인증이 만료되었거나 유효하지 않습니다.',
    DuplicateBusinessNumber() => '이미 가입된 사업자번호입니다.',
    SocialAccountNotLinked(:final provider) =>
      '${provider.displayName} 계정과 연결된 사용자를 찾을 수 없습니다.',
    CommonAuthFailure(:final failure) => switch (failure) {
      NetworkFailure() => '네트워크 연결을 확인해주세요.',
      StorageFailure() => '기기 저장소 접근에 실패했습니다.',
      ServerFailure() => '요청 처리 중 오류가 발생했습니다.',
      UnknownFailure() => '알 수 없는 오류가 발생했습니다.',
    },
  };
}
