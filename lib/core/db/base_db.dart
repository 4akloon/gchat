import 'package:hive/hive.dart';
import 'dart:developer' as developer;
import 'db.core.dart';

abstract class BaseDB {
  Box get box => DBCore().db.box(runtimeType.toString());

  Future clear() => box.clear();

  void log(String text) =>
      developer.log('$text...', name: runtimeType.toString());
}
