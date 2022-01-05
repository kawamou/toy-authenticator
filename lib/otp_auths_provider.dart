import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toy_authenticator/domain/otp_auth.dart';

final otpAuthsProvider =
    StateProvider.autoDispose<List<OTPAuth>?>((ref) => null);
