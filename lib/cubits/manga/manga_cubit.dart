// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_destroyer/enum.dart';
import 'package:flutter_destroyer/models/manga/manga_chapter.dart';
import 'package:flutter_destroyer/models/manga/manga_chapter_image.dart';
import 'package:flutter_destroyer/models/manga/manga_detail.dart';
import 'package:flutter_destroyer/models/manga/manga_list.dart';
import 'package:flutter_destroyer/models/manga/manga_thumnail.dart';
import 'package:flutter_destroyer/models/manga/manga_user_follow.dart';
import 'package:flutter_destroyer/repositories/manga_repository.dart';

part 'manga_state.dart';

class MangaCubit extends Cubit<MangaState> {
  final _mangaRepository = MangaRepository();

  MangaCubit() : super(const MangaInitial());

  Future<MangaListModel?> getMangaList() async {
    return await _mangaRepository.getMangaList(
      type: state.type,
    );
  }

  Future<MangaDetailModel?> getMangaDetail({
    required String id,
  }) async {
    return await _mangaRepository.getMangaDetail(
      id: id,
      type: state.type,
    );
  }

  Future<MangaThumnailModel?> getMangaThumnail({
    required String id,
  }) async {
    return await _mangaRepository.getMangaThumnail(
      id: id,
      type: state.type,
    );
  }

  Future<List<MangaChapterModel>> getMangaChapter({
    required String id,
  }) async {
    return await _mangaRepository.getMangaChapter(
      id: id,
      type: state.type,
    );
  }

  Future<MangaChapterImageModel?> getMangaChapterImage({
    required String detailId,
    required String chapterId,
  }) async {
    return await _mangaRepository.getMangaChapterImage(
      detailId: detailId,
      chapterId: chapterId,
      type: state.type,
    );
  }

  Future<void> getMangaUserFollow({
    required String id,
  }) async {
    final data = await _mangaRepository.getMangaUserFollow(
      id: id,
      type: state.type,
    );

    emit(MangaInitial(
      type: state.type,
      userFollow: data,
    ));
  }

  Future<void> postMangaUserFollow({
    required String detailId,
    String? chapterId,
  }) async {
    await _mangaRepository.postMangaUserFollow(
      detailId: detailId,
      chapterId: chapterId,
      type: state.type,
    );
  }

  Future<void> putMangaUserFollow({
    required String detailId,
    required String chapterId,
  }) async {
    await _mangaRepository.putMangaUserFollow(
      detailId: detailId,
      chapterId: chapterId,
      type: state.type,
    );
  }

  Future<void> deleteMangaUserFollow({
    required String id,
  }) async {
    await _mangaRepository.deleteMangaUserFollow(
      id: id,
      type: state.type,
    );
  }
}
