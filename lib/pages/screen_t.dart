import 'dart:async';

import 'package:flutter/material.dart';

class ScreenT extends StatefulWidget {
  const ScreenT({Key? key}) : super(key: key);

  @override
  State<ScreenT> createState() => _ScreenTState();
}

class _ScreenTState extends State<ScreenT> {
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Timer? timer;
  int maxDelaySec = 10;
  int idleScreenCounter = 0;

  @override
  void initState() {
    super.initState();
    initTimer();
  }

  initTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      idleScreenCounter++;
      setState(() {}); //
    });
  }

  onScreenTap() {
    print("tapped on Screen");
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
        body: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (maxDelaySec - idleScreenCounter > 0)
                    SizedBox(
                      height: 200,
                      child: Text(
                          " Tap the screen within ${maxDelaySec - idleScreenCounter}"),
                    ),
                  if (maxDelaySec - idleScreenCounter < 0)
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.cyanAccent,
                      child: const Text("Tap on screen"),
                    ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      print("An action");
                    },
                    child: const Text("A Button"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("act");
                    },
                    child: const Text("Elev"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
