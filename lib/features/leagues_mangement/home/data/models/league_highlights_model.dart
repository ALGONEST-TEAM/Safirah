class LeagueHighlightsModel {
  final int id;
  final String syncId;
  final String name;
  final String? logoUrl;
  final List<HighlightItemModel> highlights;

  LeagueHighlightsModel({
    required this.id,
    required this.syncId,
    required this.name,
    required this.logoUrl,
    required this.highlights,
  });

  factory LeagueHighlightsModel.fromJson(Map<String, dynamic> json) {
    return LeagueHighlightsModel(
      id: (json['id'] ?? 0) as int,
      syncId: (json['sync_id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      logoUrl:
          json['logo_url'] == null ? null : (json['logo_url'] ?? '').toString(),
      highlights:
          HighlightItemModel.fromJsonList((json['highlights'] ?? []) as List),
    );
  }

  static List<LeagueHighlightsModel> fromJsonList(List json) {
    return json
        .map((e) =>
            LeagueHighlightsModel.fromJson((e ?? {}) as Map<String, dynamic>))
        .toList();
  }
}

class HighlightItemModel {
  final int id;
  final String syncId;
  final String title;
  final String content;
  final String? publishedAt;
  final String matchSyncId;
  final String name;
  final List<MediaItemModel> media;

  HighlightItemModel({
    required this.id,
    required this.syncId,
    required this.title,
    required this.content,
    required this.publishedAt,
    required this.matchSyncId,
    required this.name,
    required this.media,
  });

  factory HighlightItemModel.fromJson(Map<String, dynamic> json) {
    return HighlightItemModel(
      id: (json['id'] ?? 0) as int,
      syncId: (json['sync_id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      content: (json['content'] ?? '').toString(),
      publishedAt: (json['published_at'] ?? '').toString(),
      matchSyncId: (json['match_sync_id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      media: MediaItemModel.fromJsonList((json['media'] ?? []) as List),
    );
  }

  static List<HighlightItemModel> fromJsonList(List json) {
    return json
        .map((e) =>
            HighlightItemModel.fromJson((e ?? {}) as Map<String, dynamic>))
        .toList();
  }
}

class MediaItemModel {
  final String type; // image / video
  final String url;

  MediaItemModel({required this.type, required this.url});

  factory MediaItemModel.fromJson(Map<String, dynamic> json) {
    return MediaItemModel(
      type: (json['type'] ?? '').toString(),
      url: (json['url'] ?? '').toString(),
    );
  }

  static List<MediaItemModel> fromJsonList(List json) {
    return json
        .map((e) => MediaItemModel.fromJson((e ?? {}) as Map<String, dynamic>))
        .toList();
  }

  static MediaItemModel empty() {
    return MediaItemModel(
      type: '',
      url: '',
    );
  }
}
