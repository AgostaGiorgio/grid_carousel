import 'package:flutter/material.dart';

/// Class representing the one single page.
class GridCarouselPage<T> extends StatelessWidget {
  const GridCarouselPage(
      {super.key,
      required this.grid,
      required this.cellBuilder});

  /// Grid represented as Matrix (List of Lists).
  /// This grid is created from [GridCarousel._initGrid].
  final List<List<T>> grid;
  /// Method which describe how to build each cell.
  /// This method is defined by the user and is setted when the widget [GridCarousel] is instantiated.
  final Widget Function(T) cellBuilder;

  /// Build method to render the single page.
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var row in grid)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [for (var item in row) cellBuilder(item)],
          )
      ],
    );
  }
}
