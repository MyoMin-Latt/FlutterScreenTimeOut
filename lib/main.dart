import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inactive_test/pages/screen_click.dart';
import 'package:flutter_inactive_test/pages/screen_t.dart';
import 'package:flutter_inactive_test/pages/screen_web_view_with_pop.dart';
import 'package:flutter_inactive_test/pages/some_widget.dart';

import 'pages/screen_web_view_with_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => push(const ScreenT()),
              child: const Text('Screen T'),
            ),
            ElevatedButton(
              onPressed: () => push(const SomeWidget()),
              child: const Text('Some Widget'),
            ),
            ElevatedButton(
              onPressed: () => push(const ScreenClick()),
              child: const Text('ScreenClick'),
            ),
            ElevatedButton(
              onPressed: () => push(const ScreenWebViewWithDialog()),
              child: const Text('ScreenWebViewWithDialog'),
            ),
            ElevatedButton(
              onPressed: () => push(const ScreenWebViewWithPop()),
              child: const Text('ScreenWebViewWithPop'),
            ),
          ],
        ),
      ),
    );
  }

  void push(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return page;
        },
      ),
    );
  }
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  Debouncer({this.milliseconds});

  run(
    VoidCallback action,
  ) {
    print('Debouncer Time isActive => ${timer?.isActive}');
    if (timer != null) {
      print('Debouncer Time isActive NOT NULL=> ${timer?.isActive}');
      timer!.cancel();
      print(
          'Debouncer Time isActive NOT NULL after Cancel=> ${timer?.isActive}');
    }
    timer = Timer(Duration(milliseconds: milliseconds ?? 5000), action);
    print('Debouncer Time isActive 5000 sec => ${timer?.tick}');
  }
}
