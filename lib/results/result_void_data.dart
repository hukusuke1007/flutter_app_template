import 'package:freezed_annotation/freezed_annotation.dart';

import '../exceptions/app_exception.dart';

part 'result_void_data.freezed.dart';

@freezed
class ResultVoidData with _$ResultVoidData {
  const factory ResultVoidData.success() = Success;
  const factory ResultVoidData.failure(AppException error) = Failure;
}
