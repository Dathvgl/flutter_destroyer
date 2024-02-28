import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/pages/soulLand/martialSoul/martial_soul_awaken.dart';

class MartialSoulPage extends StatelessWidget {
  const MartialSoulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: BlocBuilder<SoulLandCubit, SoulLandState>(
                builder: (context, state) {
                  if (state.martialSoul.name == "") {
                    return const Text(
                      "Chưa thức tỉnh võ hồn",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    );
                  }

                  return Text(
                    state.martialSoul.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30.0,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const MartialSoulAwaken(),
          ],
        ),
      ),
    );
  }
}
