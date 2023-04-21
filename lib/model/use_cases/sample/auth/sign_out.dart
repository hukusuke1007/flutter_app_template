import 'package:flutter_app_template/exceptions/app_exception.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/provider.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';

final signOutProvider = Provider(SignOut.new);

class SignOut {
  SignOut(this._ref);
  final Ref _ref;

  Future<void> call() async {
    try {
      await _ref.read(firebaseAuthRepositoryProvider).signOut();
      _ref
          .read(authStateProvider.notifier)
          .update((state) => AuthState.noSignIn);
    } on Exception catch (e) {
      logger.shout(e);
      throw AppException(title: 'サインアウトに失敗しました');
    }
  }
}
