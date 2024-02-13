import 'package:flutter/material.dart';
import 'package:flutter_destroyer/pages/calculator/widgets/calculator_display.dart';
import 'package:flutter_destroyer/pages/calculator/widgets/calculator_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CalculatorTileModel {
  final String name;
  final Color backgroundColor;

  CalculatorTileModel({
    required this.name,
    required this.backgroundColor,
  });
}

final _listTile = [
  CalculatorTileModel(
    name: "C",
    backgroundColor: Colors.grey.shade500,
  ),
  CalculatorTileModel(
    name: "DEL",
    backgroundColor: Colors.grey.shade500,
  ),
  CalculatorTileModel(
    name: "%",
    backgroundColor: Colors.grey.shade500,
  ),
  CalculatorTileModel(
    name: "+",
    backgroundColor: Colors.yellow.shade700,
  ),
  CalculatorTileModel(
    name: "7",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "8",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "9",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "-",
    backgroundColor: Colors.yellow.shade700,
  ),
  CalculatorTileModel(
    name: "5",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "6",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "7",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "x",
    backgroundColor: Colors.yellow.shade700,
  ),
  CalculatorTileModel(
    name: "1",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "2",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "3",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "/",
    backgroundColor: Colors.yellow.shade700,
  ),
  CalculatorTileModel(
    name: "0",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: ".",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "ANS",
    backgroundColor: Colors.grey.shade800,
  ),
  CalculatorTileModel(
    name: "=",
    backgroundColor: Colors.yellow.shade700,
  ),
];

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CalculatorDisplay(),
            Center(
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: _listTile.map((e) {
                  return CalculatorTile(
                    text: e.name,
                    backgroundColor: e.backgroundColor,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
