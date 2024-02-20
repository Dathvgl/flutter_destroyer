import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/bottomIndexed/bottom_indexed_cubit.dart';

final _itemPages = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
    icon: Icon(Icons.menu_book),
    label: 'Công Pháp',
    backgroundColor: Colors.green,
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.bloodtype_outlined),
    label: 'Võ Hồn',
    backgroundColor: Colors.cyan,
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Tu Luyện',
    backgroundColor: Colors.blue,
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.circle_outlined),
    label: 'Hồn Hoàn',
    backgroundColor: Colors.indigo,
  ),
  // const BottomNavigationBarItem(
  //   icon: Icon(Icons.boy_rounded),
  //   label: 'Hồn Cốt',
  //   backgroundColor: Colors.grey,
  // ),
];

final soulLandInfos = _itemPages.map((item) {
  return {
    "label": item.label,
    "backgroundColor": item.backgroundColor,
  };
}).toList();

class SoulLandBottomNavigation extends StatelessWidget {
  const SoulLandBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomIndexedCubit, BottomIndexedState>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: _itemPages,
          currentIndex: state.page,
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            context.read<BottomIndexedCubit>().change(index);
          },
        );
      },
    );
  }
}
