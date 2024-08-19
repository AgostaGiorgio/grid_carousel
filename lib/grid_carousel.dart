import 'package:flutter/material.dart';
import 'package:grid_carousel/grid_carousel_indicator.dart';
import 'package:grid_carousel/grid_carousel_indicator_config.dart';
import 'package:grid_carousel/grid_carousel_page.dart';
import 'package:grid_carousel/grid_size.dart';

/// Class representing the main component.
/// Internally will use both [GridCarouselPage] and [GridCarouselIndicator].
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

  /// Optional title to show on top of the component.
  final String? title;

  /// List of [Objects T] containing the data to render in each cell.
  final List<T> items;

  /// Number of rows to show.
  /// By default 1.
  final int rows;

  /// Number of columns to show.
  /// By default 3.
  final int columns;

  /// Class containing width and height of the component.
  /// By default both double.infinity.
  final GridSize size;

  /// TextStyle object used to customized the [title] (if [title] is specified).
  /// By default will be grey in bold
  final TextStyle titleStyle;

  /// EdgeInsets object used to add Padding to the [title] (if [title] is specified).
  final EdgeInsets? titlePadding;

  /// Method which describe how to build each cell.
  /// This method is used by [GridCarouselPage] component.
  final Widget Function(T) cellBuilder;

  /// Class used to customized [GridCarouselIndicator].
  /// By default is orange for the current page and grey for the others
  final GridCarouselIndicatorConfig indicatorConfig;

  @override
  State<GridCarousel<T>> createState() => _GridCarouselState<T>();
}

class _GridCarouselState<T> extends State<GridCarousel<T>> {
  /// Build method to render the component.
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

  /// Method which will create the matrix [rows]x[columns] from [items].
  /// The result of this method will be used from [GridCarousel._getPages] to create the list of [GridCarouselPage].
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

  /// Method which will convert the matrix [rows]x[columns] into list of [GridCarouselPage].
  List<GridCarouselPage<T>> _getPages(List<List<T>> grid) {
    List<GridCarouselPage<T>> pages = [];

    int skip = 0;
    int take = widget.rows;

    while (skip + take < grid.length) {
      pages.add(GridCarouselPage<T>(
          grid: grid.skip(skip).take(take).toList(),
          cellBuilder: (items) => widget.cellBuilder(items)));

      skip += take;
    }
    pages.add(GridCarouselPage<T>(
        grid: grid.skip(skip).take(take).toList(),
        cellBuilder: (items) => widget.cellBuilder(items)));

    return pages;
  }
}
