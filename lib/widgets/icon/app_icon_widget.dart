part of 'app_icon.dart';

class AppIconWidget extends StatelessWidget {
  final AppIconsParams params;

  final double _defaultWidth = 30;
  final double _defaultHeight = 30;

  const AppIconWidget({
    Key? key,
    required this.params,
  }) : super(key: key);

  double get _width {
    if (params.size != null) {
      return params.size!;
    }

    if (params.width != null) {
      return params.width!;
    }

    return _defaultWidth;
  }

  double get _height {
    if (params.size != null) {
      return params.size!;
    }

    if (params.height != null) {
      return params.height!;
    }

    return _defaultHeight;
  }

  Color? get _color {
    if (params.color != null) {
      return params.color!;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      params.icon,
      width: _width,
      height: _height,
      color: params.noColor ? null : _color,
    );
  }
}
