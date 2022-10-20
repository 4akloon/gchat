import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

part 'app_icon_ext.dart';
part 'app_icon_params.dart';
part 'app_icon_widget.dart';

class AppIcon {
  static AppIconWidget _core(String icon) {
    return AppIconWidget(
      params: AppIconsParams(icon: icon),
    );
  }
}
