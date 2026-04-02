import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_failure.freezed.dart';

@freezed
sealed class CommonFailure with _$CommonFailure {
  const factory CommonFailure.network() = NetworkFailure;
  const factory CommonFailure.server([String? message]) = ServerFailure;
  const factory CommonFailure.storage() = StorageFailure;
  const factory CommonFailure.unknown([String? message]) = UnknownFailure;
}
