import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgressIndicator extends StatefulWidget {
  const RadialProgressIndicator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RadialProgressIndicatorState();
}

class RadialProgressIndicatorState extends State<RadialProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller..repeat(), // 30秒のDurationを繰り返す
        builder: (context, _) {
          return CustomPaint(
            foregroundPainter: RadialProgress(),
          );
        });
  }
}

class RadialProgress extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue; // 図形の性質を与える
    // 親ウィジェットのsizeを受け取るのでSized Widgetである必要あり
    // 呼び出し側はContainerにconstraintsフィールドを持たせた
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    // 下記leftでアニメーションとパスコードの同期が取れる（サークルが0になると同時にパスコード更新）
    // https://qiita.com/mindwood/items/3c329d4a24bc8a3ab765
    double left = (30 - (DateTime.now().second % 30)) / 30;
    double sweepAngle = -(2 * pi * left);
    // 与えた矩形を埋めるようなarcを描画する。-pi / 2でtopからスタート
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        sweepAngle, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
