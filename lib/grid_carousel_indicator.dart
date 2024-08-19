import 'package:flutter/material.dart';
import 'package:grid_carousel/grid_carousel_indicator_config.dart';

/// Class representing the page indicator.
class GridCarouselIndicator extends StatelessWidget {
  const GridCarouselIndicator(
      {super.key,
      required this.len,
      required this.config,
      required this.controller});

  /// Total pages.
  final int len;

  /// Config class to customize the indicator.
  final GridCarouselIndicatorConfig config;

  /// PageController to get the current page while swipe animation is running.
  final PageController controller;

  /// Gets the current page selected from the controller.
  /// The intial page is 0 since the page index start from 0.
  int get currentPage {
    try {
      return controller.page!.round();
    } catch (_) {
      return controller.initialPage;
    }
  }

  /// Build method to render the indicator.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 20,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox()),
                for (var i = 0; i < len; i++)
                  Container(
                    width: (i == currentPage)
                        ? config.currentPageSize
                        : config.otherPagesSize,
                    height: (i == currentPage)
                        ? config.currentPageSize
                        : config.otherPagesSize,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (i == currentPage)
                            ? config.currentPageColor //
                            : config.otherPagesColor), //),
                  ),
                const Expanded(child: SizedBox())
              ],
            );
          }),
    );
  }
}
