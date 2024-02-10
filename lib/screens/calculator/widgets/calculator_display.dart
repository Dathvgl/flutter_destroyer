import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/screens/calculator/cubit/calculator_cubit.dart';
import 'package:flutter_destroyer/screens/calculator/widgets/calculator_field.dart';

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CalculatorField(),
              BlocBuilder<CalculatorCubit, CalculatorState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${state.result ?? ""}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
