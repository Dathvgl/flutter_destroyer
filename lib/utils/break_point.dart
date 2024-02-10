class BreakPointCheck {
  double size;
  List<String> base;

  BreakPointCheck({
    required this.size,
    this.base = const [],
  });
}

class BreakPoint {
  bool hs = false;
  bool xs = false;
  bool sm = false;
  bool md = false;
  bool lg = false;
  bool xl = false;

  BreakPoint();

  factory BreakPoint.check(BreakPointCheck check) {
    final breakPoint = BreakPoint();

    if (check.base.contains("xl")) {
      breakPoint.xl = check.size >= 1280 ? true : false;
    }

    if (check.base.contains("lg")) {
      breakPoint.lg = check.size >= 1024 ? true : false;
    }

    if (check.base.contains("md")) {
      breakPoint.md = check.size >= 768 ? true : false;
    }

    if (check.base.contains("sm")) {
      breakPoint.sm = check.size >= 640 ? true : false;
    }

    if (check.base.contains("xs")) {
      breakPoint.xs = check.size >= 576 ? true : false;
    }

    if (check.base.contains("hs")) {
      breakPoint.hs = check.size >= 480 ? true : false;
    }

    return breakPoint;
  }
}
