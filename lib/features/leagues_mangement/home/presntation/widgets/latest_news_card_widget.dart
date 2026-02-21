import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/helpers/navigateTo.dart';

import '../../../../../core/extension/string.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../data/models/league_highlights_model.dart';
import '../../data/models/news_item_model.dart';
import '../pages/news_details_page.dart';
import '../pages/video_player_page.dart';
import 'video_thumb_widget.dart';

class LatestNewsCardWidget extends StatelessWidget {
  final NewsItemModel news;
  final Size size;

  const LatestNewsCardWidget({
    super.key,
    required this.news,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateTo(context, NewsDetailsPage(id: news.id));

      },
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeTextWidget(
                    text: news.title,
                    fontSize: 11.sp,
                  ),
                  SizedBox(height: 4.h),
                  AutoSizeTextWidget(
                    text: formatDate(news.publishedAt),
                    fontSize: 10.sp,
                    colorText: AppColors.fontColor2,
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
            Expanded(
              child: MediaPreviewWidget(
                media: news.primaryMedia,
                size: size,
                onTap: () {
                  if (news.primaryMedia.type == 'video') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            VideoPlayerPage(url: news.primaryMedia.url),
                      ),
                    );
                  }else{
                    navigateTo(context, NewsDetailsPage(id: news.id));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaPreviewWidget extends StatelessWidget {
  final MediaItemModel media;
  final Size? size;
  final BoxFit fit;
  final VoidCallback? onTap;

  const MediaPreviewWidget({
    super.key,
    required this.media,
    this.size,
    this.fit = BoxFit.cover,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isVideo = media.type == 'video';

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(18.r),
            bottomLeft: Radius.circular(18.r)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!isVideo)
              OnlineImagesWidget(
                imageUrl: media.url,
                fit: fit,
                size: size,
                borderRadius: 0.r,
              )
            else
              SizedBox(
                width: size!.width,
                height: size!.height,
                child: VideoThumbWidget(
                  videoUrl: media.url,
                  fit: fit,
                ),
              ),
            if (isVideo)
              Center(
                child: Container(
                  width: 54.r,
                  height: 54.r,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
