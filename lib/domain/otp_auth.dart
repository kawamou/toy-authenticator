class OTPAuth {
  final String user;
  final String secret;

  OTPAuth({required this.user, required this.secret});

  Map<String, dynamic> toMap() {
    return {
      'issuer': user,
      'secret': secret,
    };
  }

  factory OTPAuth.fromMap(Map<String, dynamic> map) {
    return OTPAuth(
      user: map['issuer'] as String,
      secret: map['secret'] as String,
    );
  }
}
