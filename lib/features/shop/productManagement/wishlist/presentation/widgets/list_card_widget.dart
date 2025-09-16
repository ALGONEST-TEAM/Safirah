import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/online_images_widget.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/model/list_model.dart';
import '../pages/products_by_list_page.dart';
import 'list_card_options_widget.dart';

class ListCardWidget extends StatelessWidget {
  final ListModel data;

  const ListCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          ProductsByListPage(
            listId: data.id,
            listName: data.name,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.0),
              blurRadius: 1.r,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 138.h,
              child:data.image.isNotEmpty? ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(14.sp),
                itemBuilder: (context, index) {
                  return OnlineImagesWidget(
                    imageUrl: data.image[index],
                    size: Size(90.w, double.infinity),
                    borderRadius: 6.r,
                    logoWidth: 20.w,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemCount: data.image.length,
              ):Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.emptyList,
                    height: 80.h,
                    width: 20.w,
                  ),
                   4.w.horizontalSpace,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeTextWidget(
                          text: S.of(context).productsListIsEmpty,
                          fontSize: 10.8.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        8.h.verticalSpace,
                        AutoSizeTextWidget(
                          text: S
                              .of(context)
                              .addYourFavoriteProducts,
                          fontSize: 10.sp,
                          colorText: AppColors.fontColor,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                  12.w.horizontalSpace,
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AutoSizeTextWidget(
                      text: data.name,
                      maxLines: 2,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      // Icon(
                      //   Icons.share_outlined,
                      //   size: 18.5.r,
                      //   color: Colors.black87,
                      // ),
                      // 8.w.horizontalSpace,
                      InkWell(
                        onTap: () {
                          showModalBottomSheetWidget(
                            context: context,
                            backgroundColor: AppColors.scaffoldColor,
                            page: ListCardOptionsWidget(
                              listId: data.id,
                              listName: data.name,
                            ),
                          );
                        },
                        child: Icon(
                          Icons.more_horiz,
                          size: 20.r,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            5.h.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
              ),
              child: AutoSizeTextWidget(
                text: "${S.of(context).goods} ${data.productCount}",
                colorText: AppColors.fontColor,
                fontSize: 10.8.sp,
              ),
            ),
            8.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
