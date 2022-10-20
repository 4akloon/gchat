part of 'app_icon.dart';

class AppIconsParams {
  final String icon;
  final double? size;
  final double? width;
  final double? height;
  final Color? color;
  final bool noColor;

  AppIconsParams({
    required this.icon,
    this.size,
    this.width,
    this.height,
    this.color,
    this.noColor = true,
  });

  AppIconsParams copyWith({
    String? icon,
    double? size,
    double? width,
    double? height,
    Color? color,
    bool? noColor,
  }) {
    return AppIconsParams(
      icon: icon ?? this.icon,
      size: size ?? this.size,
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
      noColor: noColor ?? this.noColor,
    );
  }
}
