import 'league_highlights_model.dart';

class NewsItemModel {
  final int id;
  final String syncId;
  final String title;
  final String content;
  final bool status;
  final String? publishedAt;
  final NewsAuthor author;
  final MediaUrls mediaUrls;
  final MediaItemModel primaryMedia;

  NewsItemModel({
    required this.id,
    required this.syncId,
    required this.title,
    required this.content,
    required this.status,
    required this.publishedAt,
    required this.author,
    required this.mediaUrls,
    required this.primaryMedia,
  });

  factory NewsItemModel.fromJson(Map<String, dynamic> json) {
    return NewsItemModel(
      id: (json['id'] ?? 0) as int,
      syncId: (json['sync_id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      content: (json['content'] ?? '').toString(),
      status: json['status'] == true,
      publishedAt: (json['published_at'] ?? '').toString(),
      author: json['author'] == null
          ? NewsAuthor.empty()
          : NewsAuthor.fromJson((json['author']) as Map<String, dynamic>),
      mediaUrls: json['media_urls'] == null
          ? MediaUrls.empty()
          : MediaUrls.fromJson((json['media_urls']) as Map<String, dynamic>),
      primaryMedia: json['primary_media'] == null
          ? MediaItemModel.empty()
          : MediaItemModel.fromJson(
              (json['primary_media']) as Map<String, dynamic>),
    );
  }

  static List<NewsItemModel> fromJsonList(List json) {
    return json
        .map((e) => NewsItemModel.fromJson((e ?? {}) as Map<String, dynamic>))
        .toList();
  }

  static NewsItemModel empty() {
    return NewsItemModel(
      id: 0,
      syncId: '',
      content: '',
      status: true,
      publishedAt: '',
      title: '',
      author: NewsAuthor.empty(),
      mediaUrls: MediaUrls.empty(),
      primaryMedia: MediaItemModel.empty(),
    );
  }
}

class NewsAuthor {
  final int id;
  final String name;

  NewsAuthor({required this.id, required this.name});

  factory NewsAuthor.fromJson(Map<String, dynamic> json) {
    return NewsAuthor(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '').toString(),
    );
  }

  static NewsAuthor empty() => NewsAuthor(id: 0, name: '');
}

class MediaUrls {
  final List<String> images;
  final List<String> videos;

  MediaUrls({required this.images, required this.videos});

  factory MediaUrls.fromJson(Map<String, dynamic> json) {
    final images = (json['images'] ?? []) as List;
    final videos = (json['videos'] ?? []) as List;

    return MediaUrls(
      images: images.map((e) => (e ?? '').toString()).toList(),
      videos: videos.map((e) => (e ?? '').toString()).toList(),
    );
  }

  static MediaUrls empty() => MediaUrls(images: [], videos: []);
}
