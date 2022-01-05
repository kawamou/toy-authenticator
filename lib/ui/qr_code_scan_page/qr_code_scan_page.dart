import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toy_authenticator/ui/qr_code_scan_page/qr_code_scan_page_view_controller.dart';

class QRCodeScanPage extends ConsumerWidget {
  final GlobalKey _key = GlobalKey(debugLabel: 'QR');
  QRCodeScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    bool firstDetection = true;
    return Scaffold(
      // AppBar置けば戻るボタンが生まれる
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: _key,
              onQRViewCreated: (QRViewController qrViewController) {
                qrViewController.scannedDataStream.listen((event) {
                  if (firstDetection) {
                    firstDetection = false;
                    watch(qrCodeScanPageViewController)
                        .addOTPAuth(event.code ?? '');
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  }
                });
              },
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 16,
                borderLength: 24,
                borderWidth: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
