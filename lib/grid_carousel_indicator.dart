import 'package:flutter/material.dart';
import 'package:grid_carousel/grid_carousel_indicator_config.dart';

class GridCarouselIndicator extends StatelessWidget {
  const GridCarouselIndicator(
      {super.key,
      required this.len,
      required this.config,
      required this.controller});

  final int len;
  final GridCarouselIndicatorConfig config;
  final PageController controller;

  int get currentPage {
    try {
      return controller.page!.round();
    } catch (_) {
      return controller.initialPage;
    }
  }

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
