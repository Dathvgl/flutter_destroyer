import 'package:flutter_destroyer/models/fetch_handle.dart';
import 'package:flutter_destroyer/models/manga/manga_chapter.dart';
import 'package:flutter_destroyer/models/manga/manga_chapter_image.dart';
import 'package:flutter_destroyer/models/manga/manga_detail.dart';
import 'package:flutter_destroyer/models/manga/manga_list.dart';
import 'package:flutter_destroyer/models/manga/manga_thumnail.dart';
import 'package:flutter_destroyer/models/manga/manga_user_follow.dart';

Future<MangaListModel?> getMangaListService({
  required Map<String, dynamic> query,
}) async {
  final response = await FetchHandle().get(
    "/api/manga/list",
    queryParameters: query,
  );

  if (response == null) return null;
  return MangaListModel.fromJson(response.data);
}

Future<MangaDetailModel?> getMangaDetailService({
  required String id,
  required String type,
}) async {
  final response = await FetchHandle().get(
    "/api/manga/detail/$id?type=$type",
  );

  if (response == null) return null;
  return MangaDetailModel.fromJson(response.data);
}

Future<MangaThumnailModel?> getMangaThumnailService({
  required String id,
  required String type,
}) async {
  final response = await FetchHandle().get(
    "/api/manga/thumnail/$id?type=$type",
  );

  if (response == null) return null;
  return MangaThumnailModel.fromJson(response.data);
}

Future<List<MangaChapterModel>> getMangaChaptersService({
  required String id,
  required String type,
}) async {
  final response = await FetchHandle().get(
    "/api/manga/chapter/$id?type=$type",
  );

  if (response == null) return List.empty();
  return (response.data as List)
      .map((item) => MangaChapterModel.fromJson(item))
      .toList();
}

Future<MangaChapterImageModel?> getMangaChapterImageService({
  required String detailId,
  required String chapterId,
  required String type,
}) async {
  final response = await FetchHandle().get(
    "/api/manga/chapter/$detailId/$chapterId?type=$type",
  );

  if (response == null) return null;
  return MangaChapterImageModel.fromJson(response.data);
}

// Future<MangaListModel?> getMangaFollowService({
//   required String id,
//   required String type,
// }) async {
//   final response = await FetchHandle().get(
//     "/api/manga/list",
//   );

//   if (response == null) return null;
//   return MangaListModel.fromJson(response.data);
// }

Future<MangaUserFollow?> getMangaUserFollowService({
  required String id,
  required String type,
}) async {
  final response = await FetchHandle().get(
    "/api/user/followManga/$id",
    queryParameters: {
      "type": type,
    },
  );

  if (response == null) return null;
  return MangaUserFollow.fromJson(response.data);
}

Future<void> postMangaUserFollowService({
  required String id,
  required Map<String, dynamic> data,
}) async {
  await FetchHandle().post(
    "/api/user/followManga/$id",
    data: data,
  );
}

Future<void> putMangaUserFollowService({
  required String id,
  required Map<String, dynamic> data,
}) async {
  await FetchHandle().put(
    "/api/user/followManga/$id",
    data: data,
  );
}

Future<void> deleteMangaUserFollowService({
  required String id,
  required Map<String, dynamic> data,
}) async {
  await FetchHandle().delete(
    "/api/user/followManga/$id",
    data: data,
  );
}
