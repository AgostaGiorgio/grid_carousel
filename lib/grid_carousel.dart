import 'package:flutter/material.dart';
import 'package:grid_carousel/grid_carousel_indicator.dart';
import 'package:grid_carousel/grid_carousel_indicator_config.dart';
import 'package:grid_carousel/grid_carousel_page.dart';
import 'package:grid_carousel/grid_size.dart';

class GridCarousel<T> extends StatefulWidget {
  const GridCarousel(
      {super.key,
      this.title,
      required this.items,
      this.size =
          const GridSize(width: double.infinity, height: double.infinity),
      this.rows = 1,
      this.columns = 3,
      required this.cellBuilder,
      this.titleStyle = const TextStyle(
          color: Color.fromARGB(255, 82, 82, 82), fontWeight: FontWeight.bold),
      this.titlePadding,
      this.indicatorConfig = const GridCarouselIndicatorConfig(
          currentPageColor: Colors.orange,
          otherPagesColor: Color.fromARGB(255, 82, 82, 82))});

  final String? title;
  final List<T> items;
  final int rows;
  final int columns;
  final GridSize size;
  final TextStyle titleStyle;
  final EdgeInsets? titlePadding;
  final Widget Function(T) cellBuilder;
  final GridCarouselIndicatorConfig indicatorConfig;

  @override
  State<GridCarousel<T>> createState() => _GridCarouselState<T>();
}

class _GridCarouselState<T> extends State<GridCarousel<T>> {
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    List<GridCarouselPage> pages = _getPages(_initGrid());

    return Expanded(
        child: SizedBox(
            width: widget.size.width,
            height: widget.size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.title != null)
                  if (widget.titlePadding != null)
                    Padding(
                      padding: widget.titlePadding!,
                      child: Text(widget.title!, style: widget.titleStyle),
                    )
                  else
                    Text(widget.title!, style: widget.titleStyle),
                Expanded(
                    child: SizedBox(
                  child: SizedBox(
                      width: double.infinity,
                      child: PageView.builder(
                          controller: controller,
                          itemCount: pages.length,
                          itemBuilder: (context, index) => pages[index])),
                )),
                GridCarouselIndicator(
                    key: widget.key,
                    len: pages.length,
                    config: widget.indicatorConfig,
                    controller: controller)
              ],
            )));
  }

  List<List<T>> _initGrid() {
    List<List<T>> grid = [];

    int iterator = 0;
    int r = 0;
    while (r < widget.rows || iterator < widget.items.length) {
      List<T> row = [];

      int c = 0;
      while (c < widget.columns && iterator < widget.items.length) {
        row.add(widget.items[iterator]);
        iterator++;
        c++;
      }
      grid.add(row);
      r++;
    }

    return grid;
  }

  List<GridCarouselPage<T>> _getPages(List<List<T>> grid) {
    List<GridCarouselPage<T>> pages = [];

    int skip = 0;
    int take = widget.rows;

    while (skip + take < grid.length) {
      pages.add(GridCarouselPage<T>(
          columns: widget.columns,
          grid: grid.skip(skip).take(take).toList(),
          cellBuilder: (items) => widget.cellBuilder(items)));

      skip += take;
    }
    pages.add(GridCarouselPage<T>(
        columns: widget.columns,
        grid: grid.skip(skip).take(take).toList(),
        cellBuilder: (items) => widget.cellBuilder(items)));

    return pages;
  }
}
