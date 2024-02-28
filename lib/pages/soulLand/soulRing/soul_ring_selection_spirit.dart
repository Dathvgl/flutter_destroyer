import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/models/soulLand/soulRing/spirit_soul.dart';

class SoulRingSelectionSpirit extends StatelessWidget {
  final int index;
  final SpiritSoul spiritSoul;

  const SoulRingSelectionSpirit({
    super.key,
    required this.index,
    required this.spiritSoul,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(spiritSoul.name),
        Checkbox(
          value: context
              .watch<SoulLandCubit>()
              .state
              .soulRing
              .spiritSouls[index]
              .isYear,
          onChanged: (bool? value) {
            if (value != null) {
              context.read<SoulLandCubit>().updateSpiritSoulYear(index, value);
            }
          },
        )
      ],
    );
  }
}
