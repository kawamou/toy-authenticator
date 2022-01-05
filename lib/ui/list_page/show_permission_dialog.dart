import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> showPermissionDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('カメラを許可してください'),
          actions: [
            ElevatedButton(
              onPressed: () => {
                Navigator.pop(context),
              },
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () => {
                openAppSettings(),
              },
              child: const Text('設定'),
            )
          ],
        );
      });
}
