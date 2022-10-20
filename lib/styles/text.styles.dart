// ignore_for_file: non_constant_identifier_names

part of 'styles.dart';

final AppTextStyles = TextStyles();

class TextStyles {
  final captionBold = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    height: 1.193,
  );
  final footnote = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.1933,
  );
  final footnoteBold = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1,
  );
  final body = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.1935,
  );
  final bodyBold = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.1935,
  );
  final headline = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.1931,
  );
  final headlineBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.1931,
  );
  final title = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.3125,
  );
}

extension TextStyleExt on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
}
