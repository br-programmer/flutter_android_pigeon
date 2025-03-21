import 'package:flutter/material.dart';

/// This extension adds convenience methods to `BuildContext` for accessing
/// common `MediaQuery` properties, making it easier to get information about
/// the screen's size, padding, and other media-related data.
///
/// - `mediaQuery`: Provides the `MediaQueryData` for the current context,
///   allowing access to properties like device pixel ratio, text scale factor, etc.
/// - `qrAppSize`: Returns the size of the screen (width and height) for the current context.
/// - `height`: Retrieves the height of the screen for the current context.
/// - `width`: Retrieves the width of the screen for the current context.
/// - `padding`: Provides the padding (like system status bar or notch) for the current context.
extension MediaQueryX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get qrAppSize => MediaQuery.sizeOf(this);
  double get height => qrAppSize.height;
  double get width => qrAppSize.width;
  EdgeInsets get padding => mediaQuery.padding;
}
