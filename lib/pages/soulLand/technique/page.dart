import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/models/soulLand/technique/base.dart';
import 'package:flutter_destroyer/pages/soulLand/technique/technique_info.dart';

class TechniquePage extends StatelessWidget {
  const TechniquePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> listTiles() {
      List<Widget> widgets = <Widget>[];

      List<BaseTechnique> techniques =
          context.read<SoulLandCubit>().state.technique.tangSectTechniques;

      int n = techniques.length;

      for (var i = 0; i < n; i++) {
        if (i != 0 || i == n - 1) {
          widgets.add(const Divider());
        }

        widgets.add(TechniqueInfo(
          technique: techniques[i],
        ));
      }

      return widgets;
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListView(
            controller: ScrollController(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Center(
                  child: BlocBuilder<SoulLandCubit, SoulLandState>(
                    buildWhen: (previous, current) => false,
                    builder: (context, state) {
                      return Text(
                        state.technique.name,
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Divider(),
              ...listTiles(),
            ],
          ),
        ),
      ],
    );
  }
}
