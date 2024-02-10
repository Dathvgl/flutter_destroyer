import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/screens/calculator/cubit/calculator_cubit.dart';

class CalculatorField extends StatefulWidget {
  const CalculatorField({super.key});

  @override
  State<CalculatorField> createState() => _CalculatorFieldState();
}

class _CalculatorFieldState extends State<CalculatorField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller.addListener(onSelection);
    context.read<CalculatorCubit>().state.focusField = _focusNode.requestFocus;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  void onSelection() {
    if (_focusNode.hasFocus) {
      _controller.selection = TextSelection.fromPosition(
        TextPosition(
          offset: _controller.text.length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if (state.idle != _controller.text) {
          _controller.text = state.idle;
        }
      },
      child: TextField(
        autofocus: true,
        focusNode: _focusNode,
        controller: _controller,
        textAlign: TextAlign.end,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
