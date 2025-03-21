import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Constants for commonly used `SizedBox` and `Gap` widgets to simplify layout management.
///
/// These constants help reduce repetition when defining fixed spacing in your UI.
/// `SizedBox.shrink` is used to create an invisible `SizedBox` widget, and `Gap`
/// provides consistent spacing between elements.
///
/// - `sizedBoxShrink`: A `SizedBox` with zero width and height, useful when
///   you need an empty space without any visual impact.
/// - `gap4`: A `Gap` widget with a fixed 4-pixel vertical space.
/// - `gap8`: A `Gap` widget with a fixed 8-pixel vertical space.
/// - `gap12`: A `Gap` widget with a fixed 12-pixel vertical space.
/// - `gap16`: A `Gap` widget with a fixed 16-pixel vertical space.
/// - `gap20`: A `Gap` widget with a fixed 20-pixel vertical space.
const sizedBoxShrink = SizedBox.shrink();

const gap4 = Gap(4);
const gap8 = Gap(8);
const gap12 = Gap(12);
const gap16 = Gap(16);
const gap20 = Gap(20);
