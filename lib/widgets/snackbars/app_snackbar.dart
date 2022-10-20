import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar appSnackBar(String message) {
  return GetSnackBar(
    titleText: Text(message),
    snackPosition: SnackPosition.BOTTOM,
    messageText: const SizedBox(),
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 3),
    borderRadius: 6,
    borderWidth: 0.5,
    animationDuration: const Duration(milliseconds: 500),
  );
}
