import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/online_images_widget.dart';
import '../../../../../../core/widgets/rating_bar_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../services/auth/auth.dart';
import '../../data/model/review_data.dart';
import '../riverpod/reviews_riverpod.dart';

class CardForCommentsWidget extends ConsumerWidget {
  final ReviewData reviews;

  const CardForCommentsWidget({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(addLikeOrDislikeProvider(reviews.id).notifier);


    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 0.8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: reviews.userName,
                        colorText: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 11.5.sp,
                        minFontSize: 12,
                      ),
                    ),
                    4.w.horizontalSpace,
                    RatingBarWidget(
                      evaluation: reviews.reviewValue.toDouble(),
                      itemSize: 11.sp,
                    ),
                  ],
                ),
                3.h.verticalSpace,
                AutoSizeTextWidget(
                  text: reviews.colorName.toString().isNotEmpty
                      ? "${S.of(context).color}: ${reviews.colorName.toString()} / ${S.of(context).size}: ${reviews.sizeValue.toString()} "
                      : "${S.of(context).size}: ${reviews.sizeValue.toString()} ",
                  colorText: AppColors.fontColor,
                  fontSize: 9.5.sp,
                  minFontSize: 8,
                ),
                8.h.verticalSpace,
                AutoSizeTextWidget(
                  text: reviews.comment.toString(),
                  fontSize: 11.8.sp,
                  minFontSize: 10,
                  maxLines: 20,
                ),
              ],
            ),
          ),
          reviews.image!.isNotEmpty
              ? SizedBox(
                  height: 130.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(12.sp),
                    itemBuilder: (context, index) {
                      return OnlineImagesWidget(
                        imageUrl:reviews.image![index],
                        size: Size(130.w, double.infinity),
                        borderRadius: 4.r,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 6.w),
                    itemCount: reviews.image!.length,
                  ),
                )
              : const SizedBox.shrink(),
          reviews.image!.isNotEmpty ? 2.h.verticalSpace : 8.h.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(
                  likeCount: reviews.reviewLikeCount,
                  circleColor: const CircleColor(
                      start: Color(0xfff0687c), end: Colors.red),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Color(0xfff0687c),
                    dotSecondaryColor: Colors.red,
                  ),
                  isLiked: reviews.likeStatus.isEmpty
                      ? false
                      : reviews.likeStatus[0].status == 0
                          ? false
                          : true,
                  onTap: (bool isLiked) async {
                    if (!Auth().loggedIn) {
                      showFlashBarError(
                        context: context,
                        title: S.of(context).loginRequired,
                        text: S.of(context).pleaseLoginToContinue,
                      );
                    } else {
                      isLiked = !isLiked;
                      if (isLiked == false) {
                        state.dislike();
                      } else {
                        state.addLike();
                      }
                    }

                    return isLiked;
                  },
                  likeBuilder: (bool isLiked) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: isLiked ? 3.h : 5.h,
                        bottom: isLiked ? 3.h : 6.h,
                      ),
                      child: SvgPicture.asset(
                        isLiked ? AppIcons.like : AppIcons.disLike,
                        color: AppColors.primarySwatch.shade700.withOpacity(.9),
                      ),
                    );
                  },
                  likeCountPadding: EdgeInsets.symmetric(horizontal: 2.w),
                  countBuilder: (likeCount, isLiked, text) {
                    return AutoSizeTextWidget(
                      text: text,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                    );
                  },
                ),
                AutoSizeTextWidget(
                  text: reviews.createdAt,
                  fontSize: 9.6.sp,
                  fontWeight: FontWeight.w600,
                  colorText: AppColors.fontColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
