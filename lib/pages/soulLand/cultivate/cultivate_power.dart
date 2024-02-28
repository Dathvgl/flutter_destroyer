import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/components/widget.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';

class CultivatePower extends StatelessWidget {
  const CultivatePower({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoulLandCubit, SoulLandState>(
      buildWhen: (previous, current) {
        return previous.soulPower.energy != current.soulPower.energy;
      },
      builder: (context, state) {
        double progress = state.soulPower.energy / state.soulPower.expInfo();

        if (progress > 1.0) {
          progress = 1.0;
        }

        if (progress < 0.0) {
          progress = 0.0;
        }

        if (state.soulPower.isExp()) {
          if (state.soulPower.isName()) {
            context.read<SoulLandCubit>().updateSoulPowerBreak();
          } else {
            context.read<SoulLandCubit>().updateSoulPower();
          }
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${state.soulPower.leveling()}: ${state.soulPower.rank}",
              style: const TextStyle(
                fontSize: 25.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 35.0,
                child: PercentProgressBar(
                  textSize: 20.0,
                  progress: progress,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
