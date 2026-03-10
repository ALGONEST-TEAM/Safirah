import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:safirah/features/leagues_mangement/leagues/data/model/report_model.dart';
import 'package:safirah/features/leagues_mangement/leagues/data/model/rule_league_model.dart';

import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../home/data/models/banners_model.dart';
import '../../../home/data/models/news_item_model.dart';
import '../../../team_and_player/data/model/team_model.dart';
import '../model/league_model.dart';
import '../model/league_status_model.dart';

class LeagueRemoteDataSource {
  const LeagueRemoteDataSource();

  Future<PaginationModel<LeagueModel>> fetchLeagues({
    required int page,
    int perPage = 5,
    bool? isPrivate,
  }) async {
    final res = await RemoteRequest.getData(
      url: '/league-application/leagues',
      query: {
        'page': page,
        // support common backend key names
        'perPage': perPage,
        'per_page': perPage,
        'pageSize': perPage,
        'limit': perPage,
        if (isPrivate != null) ...{
          'is_private': isPrivate,
          'isPrivate': isPrivate,
          'private': isPrivate,
        },
      },
    );

    // Many APIs wrap pagination metadata under "data" or return it at root.
    final envelope = (res.data is Map<String, dynamic>)
        ? (res.data as Map<String, dynamic>)
        : <String, dynamic>{'data': res.data};

    final pageJson = (envelope['data'] is Map<String, dynamic>)
        ? (envelope['data'] as Map<String, dynamic>)
        : envelope;

    return PaginationModel<LeagueModel>.fromJson(
      pageJson,
      (leagues) => LeagueModel.fromJson(leagues),
    );
  }

  Future<LeagueStatusModel> getStatusOfLeague(
    String leagueSyncId,
  ) async {
    final response = await RemoteRequest.getData(
      url: '/league-application/league-status',
      query: {
        'league_sync_id': leagueSyncId,
      },
    );
    return LeagueStatusModel.fromJson(response.data['data']);
  }

  Future<LeagueBundleModel> getLeagueBundle(
    String leagueSyncId,
  ) async {
    final response = await RemoteRequest.getData(
      url: '${AppURL.baseURL}/league-application/leagues/$leagueSyncId',
    );
    print(response.data['data']['rules']);
    return LeagueBundleModel.fromJson(response.data);
  }

  Future<PaginationModel<NewsItemModel>> getAllLatestLeagueNews(
      String leagueSyncId, int page) async {
    final response = await RemoteRequest.getData(
      url: '${AppURL.baseURL}/league-application/highlights',
      query: {'page': page, 'league_sync_id': leagueSyncId},

    );
    return PaginationModel<NewsItemModel>.fromJson(
      response.data['data'] ?? response.data,
      (book) {
        return NewsItemModel.fromJson(book);
      },
    );
  }

  MediaType? _mediaTypeForFile(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return MediaType('image', 'jpeg');
      case '.png':
        return MediaType('image', 'png');
      case '.webp':
        return MediaType('image', 'webp');
      case '.gif':
        return MediaType('image', 'gif');
      case '.mp4':
        return MediaType('video', 'mp4');
      case '.mov':
        return MediaType('video', 'quicktime');
      case '.m4v':
        return MediaType('video', 'x-m4v');
      case '.avi':
        return MediaType('video', 'x-msvideo');
      case '.mkv':
        return MediaType('video', 'x-matroska');
      default:
        return null;
    }
  }

  Future<Unit> addReport(
    ReportModel reportModel,
  ) async {
    // ✅ دائماً نرفع Multipart لأن الـ API ينتظر arrays files
    final form = FormData();

    // الحقول النصية (لا تخلط معها images/videos)
    reportModel.toUploadPayload().forEach((key, value) {
      if (value == null) return;
      if (value is List) {
        for (var i = 0; i < value.length; i++) {
          form.fields.add(MapEntry('$key[$i]', value[i].toString()));
        }
      } else {
        form.fields.add(MapEntry(key, value.toString()));
      }
    });

    // ✅ images[] ملفات فقط
    final existingImages = reportModel.imagesLocalPaths
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    for (final imgPath in existingImages) {
      final mt = _mediaTypeForFile(imgPath);
      form.files.add(
        MapEntry(
          'images[]',
          await MultipartFile.fromFile(
            imgPath,
            filename: p.basename(imgPath),
            contentType: mt,
          ),
        ),
      );

      // ignore: avoid_print
      print('Attach image: ${p.basename(imgPath)} ext=${p.extension(imgPath)} mime=${mt?.mimeType}');
    }

    // ✅ videos[] ملفات فقط (حتى لو واحد)
    final vPath = reportModel.videoLocalPath?.trim();
    if (vPath != null && vPath.isNotEmpty) {
      final mt = _mediaTypeForFile(vPath);
      form.files.add(
        MapEntry(
          'videos[]',
          await MultipartFile.fromFile(
            vPath,
            filename: p.basename(vPath),
            contentType: mt,
          ),
        ),
      );

      // ignore: avoid_print
      print('Attach video: ${p.basename(vPath)} ext=${p.extension(vPath)} mime=${mt?.mimeType}');
    }

    // ✅ Logging keys
    // ignore: avoid_print
    print('Report upload fields: ${form.fields.map((e) => '${e.key}=${e.value}').toList()}');
    // ignore: avoid_print
    print('Report upload files: ${form.files.map((e) => '${e.key}:${e.value.filename}').toList()}');

    // لو الـ API *يشترط* وجود images/videos كمصفوفات حتى لو فارغة، لازم يتم ذلك من جهة backend.
    // إرسال قيم فارغة هنا سيُفشل validation.file.

    await RemoteRequest.postData(
      path: '/league-application/highlights',
      data: form,
    );

    return Future.value(unit);
  }
  Future<NewsItemModel> reportDetails({
    required int id,
  }) async {
    final response = await RemoteRequest.getData(
      url: '/league-application/highlights/show',
      query: {'id': id},
    );
    return NewsItemModel.fromJson(response.data['data']);
  }




  Future<Unit> orderLeagueInvitationsPlayer({
    required String leagueSyncId,
  }) async {
   await RemoteRequest.postData(
      path:
      '${AppURL.baseURL}/league-application/invitations',
      data: {
        'league_id': leagueSyncId,
        'invitation_type': 'join_league',
      },
    );
    return Future.value(unit);
  }
  Future<List<BannerModel>> getLeagueBanners({
 required   String leagueSyncId,
  }) async {
    final response = await RemoteRequest.getData(
      url: '${AppURL.baseURL}/league-application/leagues/get/banners',
      query: {'league_sync_id': leagueSyncId},
    );
    print(response.data['data']);
    return BannerModel.fromJsonList(response.data['data']);
  }

  Future<List<LeagueRuleModel>> getLeagueRule(
      String leagueSyncId,
      ) async {
    final response = await RemoteRequest.getData(
      url: '${AppURL.baseURL}/league-application/league-rules',
      query: {'league_sync_id': leagueSyncId},
    );
    return LeagueRuleModel.fromJsonList(response.data['data']);
  }
}
