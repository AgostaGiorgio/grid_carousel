import 'package:flutter/material.dart';
import 'package:grid_carousel/grid_carousel.dart';
import 'package:grid_carousel/grid_cell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 88, 2, 238)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Grid Carousel Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int rows = 2;
  int columns = 2;

  var items = [
    TestClassInfo("random value 1"),
    TestClassInfo("random value 2"),
    TestClassInfo("random value 3"),
    TestClassInfo("random value 4"),
    TestClassInfo("random value 5"),
    TestClassInfo("random value 6"),
    TestClassInfo("random value 7"),
    TestClassInfo("random value 8"),
    TestClassInfo("random value 9"),
    TestClassInfo("random value 10"),
  ];

  // ignore: prefer_typing_uninitialized_variables
  late var selectedItem;

  @override
  void initState() {
    super.initState();

    selectedItem = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            GridCarousel<TestClassInfo>(
              rows: rows,
              columns: columns,
              items: items,
              cellBuilder: (p0) => SimpleCell(
                data: p0,
                number: items.indexOf(p0),
                isSelected: p0 == selectedItem,
                onSelect: _onSelect,
              ),
            ),
          ],
        ));
  }

  void _onSelect(TestClassInfo item) {
    setState(() {
      selectedItem = item;
    });
  }
}

class TestClassInfo {
  String value;

  TestClassInfo(this.value);
}

class SimpleCell extends GridCell {
  const SimpleCell(
      {super.key,
      required this.data,
      required this.number,
      required this.isSelected,
      this.onSelect});

  final TestClassInfo data;
  final int number;
  final bool isSelected;
  final Function(TestClassInfo)? onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => (onSelect != null) ? onSelect!(data) : null,
      child: Container(
        color: (isSelected) ? Colors.orange : Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [Text(data.value), Text("List position: $number")],
          ),
        ),
      ),
    );
  }
}
