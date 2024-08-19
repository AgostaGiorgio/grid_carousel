# Grid Carousel

This component allows you to render a custom Grid divided automatically in pages.
You just need to define:
- list of data to render
- how each cell will look like

Easy and Fast !! 😉

<p align="center">
  <img src="https://raw.githubusercontent.com/AgostaGiorgio/grid_carousel/1.0.0/example/grid_carousel.gif" alt="Demo Example App" style="margin:auto"  width="250"  height="550">
</p>

## Getting started
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  grid_carousel: ^1.0.0
```

## Usage
Define your class with all the information to show:
```dart
class TestClassInfo {
  String value;

  TestClassInfo(this.value);
}
```

Define how each cell will look like:
```dart
class SimpleCell extends StatelessWidget {
  const SimpleCell({super.key, required this.value required this.number});

  final String value;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [Text(value), Text("List position: $number")],
        ),
      ),
    );
  }
}
```

Import the package with:
```dart
import 'package:grid_carousel/grid_carousel.dart';
```

Create your Grid component:
```dart
GridCarousel<TestClassInfo>(
    rows: rows, //default 1
    columns: columns, //default 3
    items: items, //List of TestClassInfo instances
    cellBuilder: (item) =>
        SimpleCell(value: item.value, number: items.indexOf(item)),
),
```

## Personalization
This GridCarousel component contains a lot of parameters which will allow you to customize the component based on your needs:

- `title` `str: optional` --> if specified will show a title on top of the grid
- `items` `list[T]: required` --> list of data to render
- `size` `GridSize: optional` --> size of the entire component (title + grid + page indicator circles). By default will take as much space as possible
- `rows` `int: optional` --> grid rows. By default will be 1
- `columns` `int: optional` --> grid columns. By default will be 3
- `cellBuilder` `function(T): required` --> function which describe the logic to instantiate each cell
- `titleStyle` `TextStyle: optional` --> customization for the title. By default will be gray and bold
- `titlePadding` `EdgeInsets: optional` --> padding for title. By default no padding
- `indicatorConfig` `GridCarouselIndicatorConfig: optional` --> customization for the page indicators. Size and color can be customized. By default will be orange for the current page and gray for the other with sizes respectively 14 and 11

## Examples
For more examples visit the GitHub repository and navigate under `example` folder 

## Additional information
This first version of the component is using `Rows` and `Columns` components to build one page of the Grid Carousel and `PageView` to handle all the pages.
No other components are used to build this component

## Contribute
If you have any suggestions, improvements or issues, feel free to contribute to this project.
You can either submit a new issue or propose a pull request. Direct your pull requests into the *develop* branch.