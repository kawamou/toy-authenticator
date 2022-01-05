import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toy_authenticator/ui/list_page/list_page.dart';
import 'package:toy_authenticator/ui/qr_code_scan_page/qr_code_scan_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: const ListPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const ListPage(),
          '/qrcode': (BuildContext context) => QRCodeScanPage(),
        },
      ),
    ),
  );
}
