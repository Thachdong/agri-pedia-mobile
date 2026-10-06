import 'package:freezed_annotation/freezed_annotation.dart';

part 'activate_request.freezed.dart';
part 'activate_request.g.dart';

/// Body of POST /auth/activate (`ActivateAccountDto`). [identifier] is the
/// email or phone the code was sent to; [code] matches `^\d{4,10}$`.
@freezed
abstract class ActivateRequest with _$ActivateRequest {
  const factory ActivateRequest({
    required String identifier,
    required String code,
  }) = _ActivateRequest;

  factory ActivateRequest.fromJson(Map<String, dynamic> json) =>
      _$ActivateRequestFromJson(json);
}
