import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        TextButton(
          onPressed: () {
            context.push("/calculator");
          },
          child: const Text("Calculator"),
        ),
      ],
    );
  }
}
