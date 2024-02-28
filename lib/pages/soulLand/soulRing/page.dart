import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/pages/soulLand/soulRing/soul_ring_image.dart';
import 'package:flutter_destroyer/pages/soulLand/soulRing/soul_ring_info.dart';
import 'package:flutter_destroyer/pages/soulLand/soulRing/soul_ring_selection.dart';

class SoulRingPage extends StatelessWidget {
  const SoulRingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<SoulLandCubit, SoulLandState>(
          buildWhen: (previous, current) {
            return previous.soulRing.spiritSouls.length !=
                current.soulRing.spiritSouls.length;
          },
          builder: (context, state) {
            const left = 135.0;

            return ListView.separated(
              itemCount: state.soulRing.spiritSouls.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.green.shade100,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 20.0,
                        ),
                        child: SoulRingImage(
                          spiritSoul: context
                              .watch<SoulLandCubit>()
                              .state
                              .soulRing
                              .spiritSouls[index],
                        ),
                      ),
                      Positioned(
                        bottom: 20.0,
                        left: left,
                        child: SoulRingInfo(
                          count: index,
                          left: left,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        SoulRingSelection(),
      ],
    );
  }
}
