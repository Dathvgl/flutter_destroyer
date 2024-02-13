import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/calculator/calculator_cubit.dart';

class CalculatorTile extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const CalculatorTile({
    super.key,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxWidth / 1.5;
        final fontSize = constraints.maxWidth / 3.5;

        return Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              context.read<CalculatorCubit>().press(text);
              context.read<CalculatorCubit>().state.focusField?.call();
            },
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
