import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/components/widget.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/models/soulLand/spiritual_power.dart';

class CultivateSpiritual extends StatelessWidget {
  const CultivateSpiritual({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoulLandCubit, SoulLandState>(
      buildWhen: (previous, current) {
        return previous.spiritualPower != current.spiritualPower;
      },
      builder: (context, state) {
        double progress =
            state.spiritualPower.energy / state.spiritualPower.expInfo();

        if (progress > 1.0) {
          progress = 1.0;
        }

        if (progress < 0.0) {
          progress = 0.0;
        }

        if (state.spiritualPower.isExp()) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<SoulLandCubit>().updateSpiritual();
          });
        }

        final color = SpiritualPower.colorCap[state.spiritualPower.level];
        bool check = color == Colors.white ||
            color == Colors.amber ||
            color == Colors.lime ||
            color == Colors.yellow.shade300;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${state.spiritualPower.leveling(state.spiritualPower.spiritual)}: ${state.spiritualPower.spiritual}',
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
                    textColor: check ? Colors.black : Colors.white,
                    progress: progress,
                    progressColor: color,
                    backgroundColor: Colors.blue,
                  )),
            ),
          ],
        );
      },
    );
  }
}
