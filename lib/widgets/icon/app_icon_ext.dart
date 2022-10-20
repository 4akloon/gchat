part of 'app_icon.dart';

extension AppIconExt on AppIconWidget {
  AppIconWidget size(double value) {
    return AppIconWidget(
      params: params.copyWith(size: value),
    );
  }

  AppIconWidget width(double value) {
    return AppIconWidget(
      params: params.copyWith(width: value),
    );
  }

  AppIconWidget height(double value) {
    return AppIconWidget(
      params: params.copyWith(height: value),
    );
  }

  AppIconWidget color(Color value) {
    return AppIconWidget(
      params: params.copyWith(color: value),
    );
  }

  AppIconWidget noColor() {
    return AppIconWidget(
      params: params.copyWith(noColor: true),
    );
  }
}
