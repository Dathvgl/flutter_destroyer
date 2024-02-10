part of 'calculator_cubit.dart';

sealed class CalculatorState {
  String idle;
  double? ans;
  double? result;
  VoidCallback? focusField;

  CalculatorState({
    required this.idle,
    this.ans,
    this.result,
    this.focusField,
  });
}

final class CalculatorInitial extends CalculatorState {
  CalculatorInitial({
    required super.idle,
    super.ans,
    super.result,
    super.focusField,
  });
}
