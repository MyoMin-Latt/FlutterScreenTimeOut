import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// with dialog
class ScreenWebViewWithDialog extends StatefulWidget {
  const ScreenWebViewWithDialog({Key? key}) : super(key: key);

  @override
  State<ScreenWebViewWithDialog> createState() =>
      _ScreenWebViewWithDialogState();
}

class _ScreenWebViewWithDialogState extends State<ScreenWebViewWithDialog> {
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

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('AlertDialog'),
              content: const Text('Enter your password'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    timer.cancel();
                    initTimer();
                    onScreenTap();
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              ],
            ),
          );
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
          title: const Text('ScreenWebViewWithDialog'),
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
