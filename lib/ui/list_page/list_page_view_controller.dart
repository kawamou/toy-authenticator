import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toy_authenticator/domain/otp_auth_repository.dart';
import 'package:toy_authenticator/otp_auths_provider.dart';

final listPageViewController =
    Provider.autoDispose((ref) => ListPageViewController(ref.read));

class ListPageViewController {
  final Reader _read;

  ListPageViewController(this._read);

  Future<void> initState() async {
    _read(otpAuthsProvider).state =
        await _read(otpAuthRepository).getOTPAuths();
  }

  void dispose() {
    _read(otpAuthsProvider).state?.clear();
  }
}
