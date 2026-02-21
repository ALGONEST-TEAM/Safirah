class BannerModel {
  final int id;
  final String type;
  final String status;
  final String linkUrl;
  final String imageUrl;
  final Bannerable bannerable;

  BannerModel({
    required this.id,
    required this.type,
    required this.status,
    required this.linkUrl,
    required this.imageUrl,
    required this.bannerable,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: (json['id'] ?? 0) as int,
      type: (json['type'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      linkUrl: (json['link_url'] ?? '').toString(),
      imageUrl: (json['image_url'] ?? '').toString(),
      bannerable: Bannerable.fromJson((json['bannerable'] ?? {}) as Map<String, dynamic>),
    );
  }

  static List<BannerModel> fromJsonList(List json) {
    return json
        .map((e) => BannerModel.fromJson((e ?? {}) as Map<String, dynamic>))
        .toList();
  }
}

class Bannerable {
  final String type;
  final int id;
  final String syncId;
  final String name;

  Bannerable({
    required this.type,
    required this.id,
    required this.syncId,
    required this.name,
  });

  factory Bannerable.fromJson(Map<String, dynamic> json) {
    return Bannerable(
      type: (json['type'] ?? '').toString(),
      id: (json['id'] ?? 0) as int,
      syncId: (json['sync_id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
    );
  }
}