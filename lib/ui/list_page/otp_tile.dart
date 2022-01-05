import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otp/otp.dart';
import 'package:toy_authenticator/ui/list_page/current_unix_time_state.dart';
import 'package:toy_authenticator/ui/list_page/radial_progress_indicator.dart';

class OTPTile extends StatelessWidget {
  final String secret;
  final String user;
  const OTPTile({Key? key, required this.secret, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user),
      subtitle: OTPText(secret: secret, user: user),
      trailing: Container(
        child: const RadialProgressIndicator(),
        constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
      ),
    );
  }
}

class OTPText extends ConsumerWidget {
  final String secret;
  final String user;
  const OTPText({Key? key, required this.secret, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    CurrentUnixTimeState state = watch(currentUnixTimeStateProvider).state;
    return Text(
      // https://github.com/google/google-authenticator/wiki/Key-Uri-Format
      OTP.generateTOTPCodeString(secret, state.currentUnixTime,
          algorithm: Algorithm.SHA1),
      style: const TextStyle(color: Colors.blue),
    );
  }
}
