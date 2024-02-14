import 'dart:math';

bool intNotDecimal(num value) {
  return value is int || value == value.roundToDouble();
}

double log10(num x) {
  return log(x) / log(10);
}
