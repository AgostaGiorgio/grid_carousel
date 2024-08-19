import 'package:flutter/material.dart';

/// Class representing the customization parameters for the page indicator.
class GridCarouselIndicatorConfig {
  const GridCarouselIndicatorConfig(
      {required this.currentPageColor,
      required this.otherPagesColor,
      this.currentPageSize = 14,
      this.otherPagesSize = 11});

  /// Color of the current page circle.
  final Color currentPageColor;

  /// Color of the others page circles.
  final Color otherPagesColor;

  /// Size of the current page circle.
  /// By default 14.
  final double? currentPageSize;

  /// Size of the others page circles.
  /// By default 11.
  final double? otherPagesSize;
}
