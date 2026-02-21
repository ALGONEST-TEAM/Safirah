import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/online_images_widget.dart';
import 'video_thumb_widget.dart';

class StoriesCardWidget extends StatelessWidget {
  final String imageUrl;
  final String? videoUrl;
  final bool isVideo;
  final VoidCallback onTap;

  const StoriesCardWidget({
    super.key,
    required this.imageUrl,
    required this.isVideo,
    required this.onTap,
    this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 10 / 16,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (!isVideo)
                OnlineImagesWidget(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  borderRadius: 8.r,
                )
              else
                VideoThumbWidget(videoUrl: videoUrl ?? ''),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.35),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              if (isVideo)
                Center(
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 34,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


