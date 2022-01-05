import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toy_authenticator/domain/otp_auth.dart';
import 'package:toy_authenticator/domain/otp_auth_repository.dart';
import 'package:toy_authenticator/infrastructure/shared_preferences_client.dart';

class OTPAuthRepositoryImpl implements OTPAuthRepository {
  final Reader read;
  OTPAuthRepositoryImpl(this.read);

  final _otpAuthKey = 'otpAuths';

  @override
  Future<List<OTPAuth>> getOTPAuths() async {
    final SharedPreferencesClient prefs = read(sharedPreferencesClient);
    final List<Map<String, dynamic>> otpAuthsJson =
        await prefs.getJsonList(_otpAuthKey);
    return otpAuthsJson.map((json) => OTPAuth.fromMap(json)).toList();
  }

  @override
  Future<void> saveOTPAuths(List<OTPAuth> otpAuths) async {
    final SharedPreferencesClient prefs = read(sharedPreferencesClient);
    await prefs.saveJson(
        _otpAuthKey, otpAuths.map((otpAuth) => otpAuth.toMap()).toList());
  }
}
