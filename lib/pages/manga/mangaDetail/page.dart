import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/blocs/manga/manga_bloc.dart';
import 'package:flutter_destroyer/cubits/mangaType/manga_type_cubit.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/manga_detail_build.dart';

class MangaDetailPage extends StatelessWidget {
  final String? id;

  const MangaDetailPage({
    super.key,
    this.id,
  });

  Widget nullCheck() {
    if (id is String) {
      return BlocBuilder<MangaTypeCubit, MangaTypeState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => MangaBloc()
              ..add(GetMangaDetail(
                id: id!,
                type: state.type,
              )),
            child: MangaDetailBuild(id: id!),
          );
        },
      );
    } else {
      return const Center(
        child: Text(
          "Manga not found",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return nullCheck();
  }
}
