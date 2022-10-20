import 'dart:developer' as dev;

mixin Logger {
  void logger(Object? object) =>
      dev.log(object.toString(), name: runtimeType.toString());
}
