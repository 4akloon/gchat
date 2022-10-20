import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    Key? key,
    this.reverseColor = false,
    this.center = true,
  }) : super(key: key);

  final bool reverseColor;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: reverseColor
            ? Theme.of(context).brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light
            : null,
      ),
      child: center
          ? const Center(child: CupertinoActivityIndicator())
          : const CupertinoActivityIndicator(),
    );
  }
}
