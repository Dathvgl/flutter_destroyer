import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';

const _nameShares = [
  "Hồn lực",
  "Tinh thần lực",
  "Công pháp",
  "Hồn hoàn",
];

class SoulLandEnergyShare extends StatelessWidget {
  final double maxSlider = 1.0;

  const SoulLandEnergyShare({super.key});

  double allSlider(List<double> slider) {
    double sum = slider[0] + slider[1] + slider[2] + slider[3];
    return double.parse(sum.toStringAsFixed(1));
  }

  void energyShare({
    required BuildContext context,
    required int index,
    required double rate,
  }) {
    context.read<SoulLandCubit>().updateEnergyShare(index, rate);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      content: SingleChildScrollView(
        child: BlocBuilder<SoulLandCubit, SoulLandState>(
          buildWhen: (previous, current) {
            return previous.energyShare != current.energyShare;
          },
          builder: (context, state) {
            List<double> slider = state.energyShare;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Phân chia hồn khí",
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                ..._nameShares.mapIndexed((index, item) {
                  final energy = slider[index];
                  final sumEnergy = allSlider(slider);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item),
                      Slider(
                        min: 0.0,
                        max: maxSlider,
                        divisions: 10,
                        value: energy,
                        label: "$energy",
                        onChanged: (rate) {
                          if (sumEnergy < maxSlider) {
                            energyShare(
                              context: context,
                              index: index,
                              rate: rate,
                            );
                      
                            return;
                          }
                      
                          if (sumEnergy - energy + rate < maxSlider) {
                            energyShare(
                              context: context,
                              index: index,
                              rate: rate,
                            );
                          }
                        },
                      ),
                    ],
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
