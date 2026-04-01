import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_providers.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/storage/storage_providers.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/dio_auth_remote_data_source.dart';
import '../../data/datasources/mock_auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../usecases/restore_session_usecase.dart';
import '../usecases/sign_in_usecase.dart';
import '../usecases/sign_up_usecase.dart';
import '../usecases/sign_out_usecase.dart';
import '../usecases/verify_business_number_usecase.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final appConfig = ref.watch(appConfigProvider);
  if (appConfig.apiMode == AppApiMode.mock) {
    return MockAuthRemoteDataSource();
  }

  final dio = ref.watch(dioProvider);
  return DioAuthRemoteDataSource(dio);
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthLocalDataSource(storage);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);

  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInUseCase(authRepository);
});

final verifyBusinessNumberUseCaseProvider =
    Provider<VerifyBusinessNumberUseCase>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      return VerifyBusinessNumberUseCase(authRepository);
    });

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpUseCase(authRepository);
});

final restoreSessionUseCaseProvider = Provider<RestoreSessionUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return RestoreSessionUseCase(authRepository);
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignOutUseCase(authRepository);
});
