import 'package:flutter/material.dart';
import 'package:flutter_destroyer/models/soulLand/soulRing/spirit_soul.dart';
import 'package:simple_shadow/simple_shadow.dart';

class SoulRingImage extends StatelessWidget {
  final SpiritSoul spiritSoul;

  const SoulRingImage({
    super.key,
    required this.spiritSoul,
  });

  final TextStyle style = const TextStyle(
    fontSize: 20.0,
  );

  Image anhHonHoan() {
    if (spiritSoul.level + 1 == SpiritSoul.colorCap.length) {
      return Image.asset(
        SpiritSoul.imageCap[spiritSoul.level],
      );
    }

    return Image.asset(
      SpiritSoul.imageCap[spiritSoul.level],
      color: SpiritSoul.colorCap[spiritSoul.level],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox.square(
              dimension: 120.0,
              child: SimpleShadow(
                opacity: 1.0,
                color: SpiritSoul.colorCap[spiritSoul.level],
                sigma: 10.0,
                child: anhHonHoan(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SpiritSoul.nameCap[spiritSoul.level],
                    style: style,
                  ),
                  Text(
                    "Năm: ${spiritSoul.year}",
                    style: style,
                  ),
                  Text(
                    spiritSoul.name,
                    style: style,
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          "Hệ số: ${spiritSoul.multiplier.toInt()}",
          style: style,
        ),
      ],
    );
  }
}
