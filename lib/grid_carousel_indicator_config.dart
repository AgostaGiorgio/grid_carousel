import 'package:flutter/material.dart';

class GridCarouselIndicatorConfig {
  const GridCarouselIndicatorConfig(
      {required this.currentPageColor,
      required this.otherPagesColor,
      this.currentPageSize = 14,
      this.otherPagesSize = 11});

  final Color currentPageColor;
  final Color otherPagesColor;

  final double? currentPageSize;
  final double? otherPagesSize;
}
