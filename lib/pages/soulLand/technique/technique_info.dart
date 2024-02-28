import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/components/widget.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/models/soulLand/technique/base.dart';
import 'package:flutter_destroyer/models/soulLand/technique/mysterious_heaven_technique.dart';
import 'package:flutter_destroyer/models/soulLand/technique/purple_demon_eyes.dart';

class TechniqueInfo extends StatelessWidget {
  final BaseTechnique technique;

  const TechniqueInfo({
    super.key,
    required this.technique,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TechniqueProgress(
        technique: technique,
      ),
    );
  }
}

class TechniqueProgress extends StatelessWidget {
  final BaseTechnique technique;

  const TechniqueProgress({
    super.key,
    required this.technique,
  });

  @override
  Widget build(BuildContext context) {
    switch (technique.id) {
      case MysteriousHeavenTechnique.unique:
        technique.realming(
          expNew: context.watch<SoulLandCubit>().state.soulPower.rank,
        );

        return BlocBuilder<SoulLandCubit, SoulLandState>(
          buildWhen: (previous, current) {
            return previous.soulPower.rank != current.soulPower.rank;
          },
          builder: (context, state) {
            technique.realming(
              expNew: state.soulPower.rank,
            );

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${technique.name}: ${technique.level}"),
                Text("Hệ số: ${technique.multiplier}"),
              ],
            );
          },
        );
      case PurpleDemonEyes.unique:
        return BlocBuilder<SoulLandCubit, SoulLandState>(
          buildWhen: (previous, current) {
            return previous.spiritualPower.spiritual !=
                current.spiritualPower.spiritual;
          },
          builder: (context, state) {
            technique.realming(
              expNew: state.spiritualPower.spiritual,
              map: {"spiritualPowerLevel": state.spiritualPower.level},
            );

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${technique.name}: ${technique.realm}"),
                Text(
                    "Hệ số: ${technique.multiplier.toInt().toStringAsExponential(2)}"),
              ],
            );
          },
        );
      default:
        return Column(
          children: [
            BlocBuilder<SoulLandCubit, SoulLandState>(
              buildWhen: (previous, current) {
                return previous.technique.tangSectTechniques[technique.id] !=
                    current.technique.tangSectTechniques[technique.id];
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${technique.name}: Cấp ${technique.level}"),
                    if (technique.multiplier < 1.0) ...[
                      Text("Hệ số: ${technique.multiplier.toStringAsFixed(2)}"),
                    ] else ...[
                      Text("Hệ số: ${technique.multiplier.toInt()}"),
                    ],
                  ],
                );
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 15.0,
              child: BlocBuilder<SoulLandCubit, SoulLandState>(
                buildWhen: (previous, current) {
                  return previous.technique.energy != current.technique.energy;
                },
                builder: (context, state) {
                  double exp = state.technique.shareEnergy();
                  double progress = technique.enlightenment / technique.exp;

                  if (progress > 1.0) {
                    progress = 1.0;
                  }

                  if (progress < 0.0) {
                    progress = 0.0;
                  }

                  technique.enlightenment += exp;

                  if (technique.isExp()) {
                    technique.realming(expNew: exp);
                    progress = 0;

                    state.technique.multiplierAlt();
                  }

                  return PercentProgressBar(
                    textSize: 12.0,
                    progress: progress,
                  );
                },
              ),
            )
          ],
        );
    }
  }
}
