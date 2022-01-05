import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:toy_authenticator/domain/otp_auth.dart';
import 'package:toy_authenticator/domain/otp_auth_repository.dart';
import 'package:toy_authenticator/otp_auths_provider.dart';

final qrCodeScanPageViewController =
    Provider.autoDispose((ref) => QRCodeScanPageViewController(ref.read));

class QRCodeScanPageViewController {
  final Reader _read;

  QRCodeScanPageViewController(this._read);

  Future addOTPAuth(String otpAuth) async {
    String decoded = Uri.decodeFull(otpAuth);
    final newOTPAuth = OTPAuth(
      user: _parsePathToIssuer(decoded),
      // Googleのdecodedは秘密鍵部分が小文字になっていたため
      // base32の仕様を満たせず通らなかったためアッパーに変更する
      secret: _parsePathToSecret(decoded).toUpperCase(),
    );
    final List<OTPAuth> newOTPAuthList = [
      newOTPAuth,
      ...(_read(otpAuthsProvider).state ?? [])
    ];
    _read(otpAuthsProvider).state = newOTPAuthList;
    await _read(otpAuthRepository).saveOTPAuths(newOTPAuthList);
  }

  String _parsePathToSecret(String path) {
    final url = Uri.parse(path);
    return url.queryParameters["secret"] as String;
  }

  // ex）otpauth://totp/user@servicename?secret=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
  _parsePathToIssuer(String path) {
    final url = Uri.parse(path);
    return basename(url.path);
  }
}
