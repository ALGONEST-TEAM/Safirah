import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/online_images_widget.dart';
import '../pages/video_player_page.dart';
import 'video_thumb_widget.dart';

enum _Type { image, video }

class _MediaItem {
  final _Type type;
  final String url;

  const _MediaItem(this.type, this.url);
}

class NewsDetailsMediaSliderWidget extends StatefulWidget {
  final List<String> images;
  final List<String> videos;

  const NewsDetailsMediaSliderWidget({
    super.key,
    required this.images,
    required this.videos,
  });

  @override
  State<NewsDetailsMediaSliderWidget> createState() =>
      _NewsDetailsMediaSliderWidgetState();
}

class _NewsDetailsMediaSliderWidgetState
    extends State<NewsDetailsMediaSliderWidget> {
  int _index = 0;

  List<_MediaItem> get _items {
    final list = <_MediaItem>[];
    for (final e in widget.images) {
      final u = e.trim();
      if (u.isNotEmpty) list.add(_MediaItem(_Type.image, u));
    }
    for (final e in widget.videos) {
      final u = e.trim();
      if (u.isNotEmpty) list.add(_MediaItem(_Type.video, u));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;

    if (items.isEmpty) {
      return Container(color: Colors.black12);
    }

    return Stack(
      children: [
        PageView.builder(
          itemCount: items.length,
          onPageChanged: (i) => setState(() => _index = i),
          itemBuilder: (context, i) {
            final m = items[i];

            if (m.type == _Type.image) {
              return OnlineImagesWidget(
                imageUrl: m.url,
                fit: BoxFit.cover,
                size: const Size(double.infinity, double.infinity),
                borderRadius: 0,
              );
            }
            // Video
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VideoPlayerPage(url: m.url),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: VideoThumbWidget(
                      videoUrl: m.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 60.r,
                    height: 60.r,
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      size: 34.r,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        // dots indicators (أسفل الصورة)
        Positioned(
          bottom: 10.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(items.length, (i) {
              final active = i == _index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: active ? 20.w : 7.w,
                height: 5.w,
                decoration: BoxDecoration(
                  color: active ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(99),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
