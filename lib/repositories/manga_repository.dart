import 'package:flutter_destroyer/enum.dart';
import 'package:flutter_destroyer/models/manga/manga_chapter.dart';
import 'package:flutter_destroyer/models/manga/manga_chapter_image.dart';
import 'package:flutter_destroyer/models/manga/manga_detail.dart';
import 'package:flutter_destroyer/models/manga/manga_list.dart';
import 'package:flutter_destroyer/models/manga/manga_thumnail.dart';
import 'package:flutter_destroyer/models/manga/manga_user_follow.dart';
import 'package:flutter_destroyer/services/manga_service.dart';

class MangaRepository {
  Future<MangaListModel?> getMangaList({
    required MangaType type,
  }) async {
    return await getMangaListService(
      query: {
        "type": type.name,
        "sort": "lastest",
        "order": "desc",
      },
    );
  }

  Future<MangaThumnailModel?> getMangaThumnail({
    required String id,
    required MangaType type,
  }) async {
    return await getMangaThumnailService(
      id: id,
      type: type.name,
    );
  }

  Future<MangaDetailModel?> getMangaDetail({
    required String id,
    required MangaType type,
  }) async {
    return await getMangaDetailService(
      id: id,
      type: type.name,
    );
  }

  Future<List<MangaChapterModel>> getMangaChapter({
    required String id,
    required MangaType type,
  }) async {
    return await getMangaChaptersService(
      id: id,
      type: type.name,
    );
  }

  Future<MangaChapterImageModel?> getMangaChapterImage({
    required String detailId,
    required String chapterId,
    required MangaType type,
  }) async {
    return await getMangaChapterImageService(
      detailId: detailId,
      chapterId: chapterId,
      type: type.name,
    );
  }

  Future<MangaUserFollow?> getMangaUserFollow({
    required String id,
    required MangaType type,
  }) async {
    return await getMangaUserFollowService(
      id: id,
      type: type.name,
    );
  }

  Future<void> postMangaUserFollow({
    required String detailId,
    String? chapterId,
    required MangaType type,
  }) async {
    await postMangaUserFollowService(
      id: detailId,
      data: {
        "type": type.name,
        "chapter": chapterId ?? "empty",
      },
    );
  }

  Future<void> putMangaUserFollow({
    required String detailId,
    required String chapterId,
    required MangaType type,
  }) async {
    await putMangaUserFollowService(
      id: detailId,
      data: {
        "type": type.name,
        "replace": false,
        "currentChapter": chapterId,
      },
    );
  }

  Future<void> deleteMangaUserFollow({
    required String id,
    required MangaType type,
  }) async {
    await deleteMangaUserFollowService(
      id: id,
      data: {
        "type": type.name,
      },
    );
  }
}
