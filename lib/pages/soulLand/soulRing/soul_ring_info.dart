import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/components/widget.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/models/soulLand/soulRing/spirit_soul.dart';

class SoulRingInfo extends StatelessWidget {
  final int count;
  final double left;

  const SoulRingInfo({
    super.key,
    required this.count,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    double capnhatTuLuyen(double honkhi) {
      SpiritSoul spiritSoul =
          context.read<SoulLandCubit>().state.soulRing.spiritSouls[count];

      int kinhnghiem = spiritSoul.expInfo();
      double progress = honkhi / kinhnghiem;

      if (progress > 1.0) {
        progress = 1.0;
      }

      if (progress < 0.0) {
        progress = 0.0;
      }

      if (!spiritSoul.isYear) {
        return progress;
      }

      if (honkhi >= kinhnghiem.toDouble()) {
        if (spiritSoul.isName()) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<SoulLandCubit>().updateSoulRingBreak(count);
          });
          return progress;
        }

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.read<SoulLandCubit>().updateSoulRing(count);
        });
        progress = 0;
      }
      return progress;
    }

    double widthSized(double extra) {
      double basePadding = 20.0;
      double screenW = MediaQuery.of(context).size.width;
      return screenW - basePadding - extra;
    }

    return SizedBox(
      width: widthSized(left),
      height: 15.0,
      child: PercentProgressBar(
        textSize: 12.0,
        progress: capnhatTuLuyen(
          context
              .watch<SoulLandCubit>()
              .state
              .soulRing
              .spiritSouls[count]
              .energy,
        ),
      ),
    );
  }
}
