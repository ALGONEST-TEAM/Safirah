import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/buttons/icon_button_widget.dart';
import 'package:safirah/core/widgets/logo_shimmer_widget.dart';

import '../../../../../core/extension/string.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/home_riverpod.dart';
import '../widgets/news_details_media_slider_widget.dart';

class NewsDetailsPage extends ConsumerWidget {
  final int id;

  const NewsDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newsDetailsProvider(id));

    return Scaffold(
      body: SafeArea(
        top: false,
        child: CheckStateInGetApiDataWidget(
          state: state,
          refresh: () => ref.invalidate(newsDetailsProvider(id)),
          widgetOfLoading: const LogoShimmerWidget(),
          widgetOfData: SingleChildScrollView(
            child: Column(
              children: [
                // ======= Top Media (Image/Video Slider) =======
                Stack(
                  children: [
                    SizedBox(
                      height: 320.h,
                      width: double.infinity,
                      child: NewsDetailsMediaSliderWidget(
                        images: state.data.mediaUrls.images,
                        videos: state.data.mediaUrls.videos,
                      ),
                    ),
                    Positioned(
                      top: 30.h,
                      right: 12.w,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const IconButtonWidget(),
                      ),
                    ),
                  ],
                ),
            
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 18.h),
                  padding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h)
                      .copyWith(bottom: 24.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeTextWidget(
                        text: formatDate(state.data.publishedAt),
                        fontSize: 10.sp,
                        colorText: Colors.black87,
                      ),
                      SizedBox(height: 10.h),
                      AutoSizeTextWidget(
                        text: state.data.title,
                        fontSize: 14.sp,
                        maxLines: 4,
                        fontWeight: FontWeight.w600,
                      ),
                  
                      4.h.verticalSpace,
                      Text(
                        state.data.content,
                        style: TextStyle(
                          fontSize: 12.sp,
                          height: 1.7,
                          color: Colors.black87,
                        ),
                      ),
                  
                      // رابط (إذا موجود)
                      if (_extractUrl(state.data.content) != null) ...[
                        SizedBox(height: 14.h),
                        Center(
                          child: SelectableText(
                            _extractUrl(state.data.content)!,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: 18.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _extractUrl(String text) {
    final reg = RegExp(r'(https?:\/\/[^\s]+)');
    return reg.firstMatch(text)?.group(0);
  }
}
