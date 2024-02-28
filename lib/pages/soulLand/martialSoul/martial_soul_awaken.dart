import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/models/soulland/martialSoul/index.dart';

class MartialSoulAwaken extends StatelessWidget {
  const MartialSoulAwaken({super.key});

  void updateMartialSoul({
    required BuildContext context,
    required int index,
  }) {
    context.read<SoulLandCubit>().updateMartialSoul(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoulLandCubit, SoulLandState>(
      buildWhen: (previous, current) {
        return previous.soulPower.rank != current.soulPower.rank;
      },
      builder: (context, state) {
        if (state.soulPower.rank > 0) {
          return Column(
            children: [
              Text(
                '${MartialSoul.rank[state.martialSoul.level]} ${state.martialSoul.quality}',
                style: const TextStyle(
                  fontSize: 30.0,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 350.0,
                height: 10.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const LinearProgressIndicator(
                    value: 0.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    backgroundColor: Colors.lightBlue,
                  ),
                ),
              )
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade300,
                shape: const CircleBorder(),
                fixedSize: const Size(100, 100),
              ),
              onPressed: () => updateMartialSoul(
                context: context,
                index: 0,
              ),
              child: const Text(
                "Thức tỉnh khí võ hồn",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade900,
                shape: const CircleBorder(),
                fixedSize: const Size(100, 100),
              ),
              onPressed: () => updateMartialSoul(
                context: context,
                index: 1,
              ),
              child: const Text(
                "Thức tỉnh thú võ hồn",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
