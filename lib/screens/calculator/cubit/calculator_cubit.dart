// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial(idle: ""));

  void press(String name) {
    double? result;
    String str = state.idle;

    switch (name) {
      case "C":
        str = "";
        break;
      case "DEL":
        if (str.isNotEmpty) {
          str = str.substring(0, str.length - 1);
        }

        break;
      case "ANS":
        break;
      case "=":
      default:
        str = state.idle + name;
    }

    if (str.isNotEmpty) {
      bool equal = false;
      Parser p = Parser();
      String expression = str.replaceAll("x", "*");

      if (expression.contains("=")) {
        equal = true;
        expression = expression.replaceAll("=", "");
      }

      try {
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();

        result = exp.evaluate(EvaluationType.REAL, cm);

        if (equal) {
          str = result.toString();
          result = null;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }

    emit(CalculatorInitial(
      idle: str,
      result: result,
      focusField: state.focusField,
    ));
  }
}
