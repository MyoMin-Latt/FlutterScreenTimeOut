import 'dart:async';

import 'package:flutter/material.dart';

class ScreenClick extends StatefulWidget {
  const ScreenClick({Key? key}) : super(key: key);

  @override
  State<ScreenClick> createState() => _ScreenClickState();
}

class _ScreenClickState extends State<ScreenClick> {
  Timer? timer;
  int maxDelaySec = 10;
  int idleScreenCounter = 0;
  int counter = 0;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initTimer();
  }

  initTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        idleScreenCounter++;
        if (idleScreenCounter == 7) {
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
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (maxDelaySec - idleScreenCounter > 0)
                Text(
                  " Tap the screen within ${maxDelaySec - idleScreenCounter}",
                  style: const TextStyle(fontSize: 24),
                ),
              if (maxDelaySec - idleScreenCounter < 0)
                const Text(
                  "Tap on screen",
                  style: TextStyle(fontSize: 24),
                ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  counter.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                },
                child: const Text("Increase counter"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
