import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';

class SoulLandReset extends StatelessWidget {
  const SoulLandReset({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      title: const Text(
        "Trở lại làm tân thủ",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        "Khi nhấn thì tất cả tu vi sẽ mất",
        textAlign: TextAlign.justify,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10.0,
            right: 10.0,
          ),
          child: TextButton(
            onPressed: () {
              context.read<SoulLandCubit>().reset();
              Navigator.pop(context, true);
            },
            child: const Text(
              "Chấp nhận?",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
