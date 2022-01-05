import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toy_authenticator/domain/otp_auth.dart';
import 'package:toy_authenticator/infrastructure/otp_auth_repository_impl.dart';

final otpAuthRepository = Provider.autoDispose<OTPAuthRepository>(
    (ref) => OTPAuthRepositoryImpl(ref.read));

abstract class OTPAuthRepository {
  Future<List<OTPAuth>> getOTPAuths();
  Future<void> saveOTPAuths(List<OTPAuth> otpAuths);
}
