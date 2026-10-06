import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/register_request.dart';

part 'register_controller.g.dart';

/// Submits the register form. Invalidates nothing: no cached data depends on
/// a new, not-yet-logged-in account.
@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<void> build() {}

  /// True on success; on failure `state` holds the `ApiException`.
  Future<bool> submit(RegisterRequest request) async {
    final buildRef = ref; // `ref` returns the latest Ref after a rebuild
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).register(request),
    );
    if (!buildRef.mounted) return false;
    state = result;
    return !state.hasError;
  }
}
