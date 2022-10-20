// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';

import '../config.core.dart';

class ConfigEasterEgg extends StatelessWidget {
  ConfigEasterEgg({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  bool containCircle(Offset a, Offset b) {
    final distance = sqrt(pow(b.dx - a.dx, 2) + pow(b.dy - a.dy, 2));
    return distance <= 40;
  }

  final _places = const [
    Offset(-80, 90),
    Offset(0, -100),
    Offset(80, 90),
    Offset(-100, -80),
    Offset(100, -80),
    Offset(-80, 90),
  ];

  int step = 0;
  bool complete = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (complete) return;
        if (containCircle(_places[step], details.localPosition)) step++;
        if (_places.length < step + 1) {
          complete = true;
          ConfigCore().showConfigChanger();
        }
      },
      onVerticalDragEnd: (details) {
        step = 0;
        complete = false;
      },
      child: child,
    );
  }
}
