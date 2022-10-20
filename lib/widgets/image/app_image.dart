// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
part 'app_image.ext.dart';

class AppImageCore extends StatelessWidget {
  const AppImageCore({Key? key, required this.params}) : super(key: key);

  final AppImageParams params;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      params.path,
      height: params.height,
      width: params.width,
      fit: params.fit,
    );
  }

  AppImageCore size({double? height, double? width}) =>
      AppImageCore(params: params.copyWith(height: height, width: width));
  AppImageCore fit(BoxFit fit) =>
      AppImageCore(params: params.copyWith(fit: fit));
}

class AppImageParams {
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const AppImageParams(this.path, {this.height, this.width, this.fit});

  AppImageParams copyWith({
    String? path,
    double? height,
    double? width,
    BoxFit? fit,
  }) {
    return AppImageParams(
      path ?? this.path,
      height: height ?? this.height,
      width: width ?? this.width,
      fit: fit ?? this.fit,
    );
  }
}
