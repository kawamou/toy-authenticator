import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toy_authenticator/domain/otp_auth.dart';
import 'package:toy_authenticator/otp_auths_provider.dart';
import 'package:toy_authenticator/ui/list_page/list_page_view_controller.dart';
import 'package:toy_authenticator/ui/list_page/otp_tile.dart';
import 'package:toy_authenticator/ui/list_page/settings_popup_menu.dart';
import 'package:toy_authenticator/ui/list_page/show_permission_dialog.dart';

class ListPage extends ConsumerWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    context.read(listPageViewController).initState(); // 一度だけ
    final List<OTPAuth>? otpAuthList = watch(otpAuthsProvider).state;

    return Scaffold(
      appBar: AppBar(
        actions: const [
          SettingsPopUpMenu(),
        ],
      ),
      body: otpAuthList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: otpAuthList.length,
              itemBuilder: (context, int idx) => OTPTile(
                  secret: otpAuthList[idx].secret, user: otpAuthList[idx].user),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () async {
          if (await Permission.camera.request().isGranted) {
            Navigator.pushNamed(context, '/qrcode');
          } else {
            await showPermissionDialog(context);
          }
        },
      ),
    );
  }
}
