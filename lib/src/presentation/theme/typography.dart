import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle defaultTextStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    height: 1,
  );
}

class AppText extends StatelessWidget {
  final TextSize textSize;
  final String text;
  final TextStyle? textStyle;
  final bool isBold;
  final bool isSelectable;
  final Color? color;
  final TextAlign? textAlign;
  final bool isSingleLine;

  const AppText(
    this.text, {
    super.key,
    this.textSize = TextSize.s,
    this.textStyle,
    this.isBold = false,
    this.isSelectable = false,
    this.color,
    this.textAlign,
    this.isSingleLine = false,
  });

  const AppText.xs(
    this.text, {
    super.key,
    this.textStyle,
    this.isBold = false,
    this.isSelectable = false,
    this.color,
    this.textAlign,
    this.isSingleLine = false,
  }) : textSize = TextSize.xs;

  const AppText.s(
    this.text, {
    super.key,
    this.textStyle,
    this.isBold = false,
    this.isSelectable = false,
    this.color,
    this.textAlign,
    this.isSingleLine = false,
  }) : textSize = TextSize.s;

  const AppText.m(
    this.text, {
    super.key,
    this.textStyle,
    this.isBold = false,
    this.isSelectable = false,
    this.color,
    this.textAlign,
    this.isSingleLine = false,
  }) : textSize = TextSize.m;

  const AppText.l(
    this.text, {
    super.key,
    this.textStyle,
    this.isBold = false,
    this.isSelectable = false,
    this.color,
    this.textAlign,
    this.isSingleLine = false,
  }) : textSize = TextSize.l;

  const AppText.xl(
    this.text, {
    super.key,
    this.textStyle,
    this.isBold = false,
    this.isSelectable = false,
    this.color,
    this.textAlign,
    this.isSingleLine = false,
  }) : textSize = TextSize.xl;

  const AppText.xxl(
    this.text, {
    super.key,
    this.textStyle,
    this.isBold = false,
    this.isSelectable = false,
    this.color,
    this.textAlign,
    this.isSingleLine = false,
  }) : textSize = TextSize.xxl;

  TextStyle get style => AppTypography.defaultTextStyle.copyWith(
        fontSize: textSize.size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle != null ? textStyle!.merge(style) : style);
  }
}

enum TextSize {
  xs(12),
  s(14),
  m(16),
  l(20),
  xl(24),
  xxl(32);

  final double size;
  const TextSize(this.size);
}
