import 'package:flutter/material.dart';

extension MediaQueryX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get qrAppSize => MediaQuery.sizeOf(this);
  double get height => qrAppSize.height;
  double get width => qrAppSize.width;
  EdgeInsets get padding => mediaQuery.padding;
}
