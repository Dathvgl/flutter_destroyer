import 'package:flutter/material.dart';
import 'package:flutter_destroyer/models/route.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: routes.sublist(1).map((item) {
          return TextButton(
            onPressed: () {
              context.push(item.path);
            },
            child: Text(item.name),
          );
        }).toList(),
      ),
    );
  }
}
