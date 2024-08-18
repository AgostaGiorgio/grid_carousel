import 'package:flutter/material.dart';

class GridCarouselPage<T> extends StatelessWidget {
  const GridCarouselPage(
      {super.key,
      required this.grid,
      required this.cellBuilder,
      required this.columns});

  final List<List<T>> grid;
  final Widget Function(T) cellBuilder;
  final int columns;

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
