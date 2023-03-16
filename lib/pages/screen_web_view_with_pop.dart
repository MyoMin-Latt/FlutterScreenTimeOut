import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// with pop
class ScreenWebViewWithPop extends StatefulWidget {
  const ScreenWebViewWithPop({Key? key}) : super(key: key);

  @override
  State<ScreenWebViewWithPop> createState() => _ScreenWebViewWithPopState();
}

class _ScreenWebViewWithPopState extends State<ScreenWebViewWithPop> {
  @override
  void initState() {
    super.initState();
    initTimer();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Timer? timer;
  int maxDelaySec = 15;
  int idleScreenCounter = 0;
  int counter = 0;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  initTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        idleScreenCounter++;
        if (idleScreenCounter == maxDelaySec) {
          debugPrint('idleScreenCounter $idleScreenCounter');
          Navigator.pop(context);
        }
        debugPrint('Time ${timer.tick}');
        setState(() {}); //
      },
    );
  }

  onScreenTap() {
    debugPrint("tapped on Screen");
    idleScreenCounter = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanDown: (_) => onScreenTap(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ScreenWebViewWithPop'),
        ),
        body: const WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              'https://myominlatt.notion.site/Flutter-Note-b7417ac13f7b48a5b46959abb8ee51de',
        ),
      ),
    );
  }
}
