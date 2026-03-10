import 'package:uuid/uuid.dart';

class ReportModel {
  final int? id;

  /// معرف مزامنة/إنشاء محلي لتتبع التقرير قبل وبعد الرفع
  final String syncId;

  /// ربط التقرير بمباراة/دوري (اختياري حسب احتياج الـ API لديك)
  final String? leagueSyncId;
  final String? matchSyncId;

  final String title;
  final String details;

  /// ملفات محلية
  final List<String> imagesLocalPaths;
  final String? videoLocalPath;

  /// ملفات/روابط من السيرفر بعد الرفع
  final List<String> imagesRemoteUrls;
  final String? videoRemoteUrl;

  final DateTime createdAt;

  ReportModel({
    this.id,
    String? syncId,
    this.leagueSyncId,
    this.matchSyncId,
    required this.title,
    required this.details,
    List<String>? imagesLocalPaths,
    this.videoLocalPath,
    List<String>? imagesRemoteUrls,
    this.videoRemoteUrl,
    DateTime? createdAt,
  })  : syncId = (syncId != null && syncId.trim().isNotEmpty)
            ? syncId.trim()
            : const Uuid().v4(),
        imagesLocalPaths = List.unmodifiable(imagesLocalPaths ?? const []),
        imagesRemoteUrls = List.unmodifiable(imagesRemoteUrls ?? const []),
        createdAt = createdAt ?? DateTime.now();

  ReportModel copyWith({
    int? id,
    String? syncId,
    String? leagueSyncId,
    String? matchSyncId,
    String? title,
    String? details,
    List<String>? imagesLocalPaths,
    String? videoLocalPath,
    List<String>? imagesRemoteUrls,
    String? videoRemoteUrl,
    DateTime? createdAt,
  }) {
    return ReportModel(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      title: title ?? this.title,
      details: details ?? this.details,
      imagesLocalPaths: imagesLocalPaths ?? this.imagesLocalPaths,
      videoLocalPath: videoLocalPath ?? this.videoLocalPath,
      imagesRemoteUrls: imagesRemoteUrls ?? this.imagesRemoteUrls,
      videoRemoteUrl: videoRemoteUrl ?? this.videoRemoteUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // --------------------------
  // API JSON
  // --------------------------

  /// من الـ API (غالباً سيأتي فقط الروابط وليس الملفات المحلية)
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    final images = (json['images'] ?? json['images_urls'] ?? json['imagesUrls']);

    return ReportModel(
      id: json['id'] as int?,
      syncId: (json['sync_id'] ?? json['syncId']) as String?,
      leagueSyncId: json['league_sync_id'] as String?,
      matchSyncId: json['match_sync_id'] as String?,
      title: (json['title'] ?? '').toString(),
      details: (json['details'] ?? json['description'] ?? '').toString(),
      imagesRemoteUrls: (images is List)
          ? images.map((e) => e.toString()).where((e) => e.trim().isNotEmpty).toList()
          : const [],
      videoRemoteUrl: (json['video_url'] ?? json['videoUrl'])?.toString(),
      createdAt: _parseDate(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
    );
  }

  /// JSON لإرسال البيانات النصية للـ API.
  ///
  /// ملاحظة: رفع الصورة/الفيديو غالباً يكون Multipart بشكل منفصل.
  /// لذلك هنا نرسل فقط الحقول النصية + المعرفات.
  Map<String, dynamic> toJson() => {
        'sync_id': syncId,
        if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
        //if (matchSyncId != null)
    'match_sync_id': matchSyncId,
        'title': title,
        'content': details,
        // في حال الـ API يقبل روابط الصور (بعد رفعها)
        if (imagesRemoteUrls.isNotEmpty) 'images': imagesRemoteUrls,
        if (videoRemoteUrl != null && videoRemoteUrl!.trim().isNotEmpty) 'videos': videoRemoteUrl,
        'created_at': createdAt.toIso8601String(),
      };

  /// JSON مخصص لـ multipart: يعيد فقط مسارات الملفات المحلية التي ستُرفع.
  /// (تستخدمه من داخل RemoteDataSource عند بناء الطلب).
  Map<String, dynamic> toUploadPayload() => {
        'sync_id': syncId,
        if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
    'match_sync_id': '019cbb57-bcab-7837-8aec-e7377d4ba664',

    'title': title,
        'content': details,
      };

  // --------------------------
  // Drift helpers (اختياري)
  // --------------------------

  /// لتخزين القوائم في قاعدة البيانات كسلسلة نصية.
  /// استخدم هذا فقط إذا قررت إنشاء جدول للتقارير.
  static String encodeList(List<String> list) => list.join('|');

  static List<String> decodeList(String? encoded) {
    final v = (encoded ?? '').trim();
    if (v.isEmpty) return const [];
    return v.split('|').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }
}

DateTime? _parseDate(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String && v.trim().isNotEmpty) return DateTime.tryParse(v);
  return null;
}
