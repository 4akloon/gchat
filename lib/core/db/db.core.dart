import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'base_db.dart';

class DBCore {
  final List<BaseDB> databases;

  DBCore._(this.databases);
  factory DBCore() => Get.find<DBCore>();
  static Future<void> initialize(List<BaseDB> databases) async {
    String? path;
    if (!kIsWeb) path = (await getTemporaryDirectory()).path;
    Hive.init(path);
    await Future.forEach(
      databases,
      (element) => Hive.openBox(element.runtimeType.toString()),
    );
    Get.put<DBCore>(DBCore._(databases), permanent: true);
  }

  HiveInterface get db => Hive;

  T getDataBase<T>() => databases.firstWhere((element) => element is T) as T;

  Future<void> clear() =>
      Future.forEach(databases, (BaseDB element) => element.clear());
}
