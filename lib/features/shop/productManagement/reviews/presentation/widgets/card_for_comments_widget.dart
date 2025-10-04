import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../services/auth/auth.dart';
import '../../data/model/review_data.dart';
import '../riverpod/reviews_riverpod.dart';
import 'comment_card_information_widget.dart';
import 'review_images_strip_widget.dart';

class CardForCommentsWidget extends ConsumerWidget {
  final ReviewData reviews;
  final bool detailsPage;

  const CardForCommentsWidget({
    super.key,
    required this.reviews,
    this.detailsPage = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(addLikeOrDislikeProvider(reviews.id).notifier);
    String fixedDate =
        "${reviews.createdAt.substring(0, 10)} ${reviews.createdAt.substring(10)}";
    DateTime date = DateTime.parse(fixedDate);

    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: detailsPage ? AppColors.scaffoldColor : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommentCardInformationWidget(
            reviews: reviews,
            date: date,
          ),
          2.h.verticalSpace,
          ReviewImagesStripWidget(images: reviews.image ?? ['']),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(
                  likeCount: reviews.reviewLikeCount,
                  circleColor: const CircleColor(
                    start: Color(0xfff0687c),
                    end: Colors.red,
                  ),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Color(0xfff0687c),
                    dotSecondaryColor: Colors.red,
                  ),
                  isLiked: reviews.likeStatus == 0 ? false : true,
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
                      padding: EdgeInsets.symmetric(vertical: 3.6.h),
                      child: SvgPicture.asset(
                        isLiked ? AppIcons.like : AppIcons.disLike,
                      ),
                    );
                  },
                  likeCountPadding: EdgeInsets.symmetric(horizontal: 2.w),
                  countBuilder: (likeCount, isLiked, text) {
                    return AutoSizeTextWidget(
                      text: text,
                      fontSize: 9.6.sp,
                      fontWeight: FontWeight.w600,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
