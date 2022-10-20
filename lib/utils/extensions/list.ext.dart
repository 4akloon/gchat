import 'dart:math' as math;

extension ListExt on List {
  List<dynamic> mapSaparated<T>(
    dynamic Function(T) itemBuilder,
    dynamic Function(int) separatorBuilder,
  ) =>
      List.generate(
        math.max(0, length * 2 - 1),
        (index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            return itemBuilder(this[itemIndex]);
          } else {
            return separatorBuilder(itemIndex);
          }
        },
      );
}
