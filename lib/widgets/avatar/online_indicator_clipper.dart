import 'package:flutter/material.dart';

class OnlineIndicatorClipper extends CustomClipper<Path> {
  final bool online;

  OnlineIndicatorClipper(this.online);
  @override
  Path getClip(Size size) {
    final borderCircle = Path();
    borderCircle.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.height / 2,
      ),
    );
    final dotCircle = Path();
    dotCircle.addOval(
      Rect.fromCircle(
        center: Offset(size.height - 6, size.width - 5),
        radius: 7,
      ),
    );

    return online
        ? Path.combine(PathOperation.difference, borderCircle, dotCircle)
        : borderCircle;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
