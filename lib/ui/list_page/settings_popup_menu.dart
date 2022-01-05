import 'package:flutter/material.dart';

class SettingsPopUpMenu extends StatelessWidget {
  const SettingsPopUpMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => [
        // Menuの各項目にはPopupMenuItem、罫線にはPopupMenuDividerを使う
        PopupMenuItem(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('設定'),
            ],
          ),
        ),
      ],
    );
  }
}
