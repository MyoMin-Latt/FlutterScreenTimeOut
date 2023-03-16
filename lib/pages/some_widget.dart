import 'dart:async';

import 'package:flutter/material.dart';

class SomeWidget extends StatefulWidget {
  const SomeWidget({super.key});

  @override
  State<SomeWidget> createState() => _SomeWidgetState();
}

class _SomeWidgetState extends State<SomeWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // It's up to you if you want the timer to start immediately with some effects or not.
    _timer = Timer(const Duration(seconds: 1), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          // i.e. from the first interaction and so on
          _timer.cancel();
          _timer = Timer(const Duration(seconds: 1), () {
            if (mounted) {
              // !
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Some message')),
              );
            }
          });
        },
        child: const Center(child: Text('My screen contents')),
      ),
    );
  }
}
