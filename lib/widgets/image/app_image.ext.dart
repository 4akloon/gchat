part of 'app_image.dart';

extension AppImage on AppImageCore {
  static AppImageCore create(String path) =>
      AppImageCore(params: AppImageParams(path));

  static AppImageCore avatar(int i) => create('assets/images/avatars/$i.png');
  static AppImageCore get chat => create('assets/images/chat.png');
}
