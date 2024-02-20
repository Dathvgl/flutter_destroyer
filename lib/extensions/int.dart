import 'package:flutter_destroyer/extensions/string.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

extension CustomInt on int {
  String timestampMilli({bool full = false}) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      this * 1000,
      isUtc: true,
    );

    return timeago
        .format(dateTime, locale: full ? "en" : "en_short")
        .toCapitalized();
  }

  String humanCompact() {
    return NumberFormat().format(this);
  }
}
