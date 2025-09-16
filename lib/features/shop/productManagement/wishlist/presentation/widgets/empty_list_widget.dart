import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import 'create_a_new_list_dialog_widget.dart';

class EmptyListWidget extends ConsumerWidget {
  final double? iconHeight;
  final double? buttonWidth;
  final bool navigator;
  final bool navigateToProductSelectionPage;
  const EmptyListWidget({
    super.key,
    this.iconHeight,
    this.buttonWidth,
    this.navigator = true,
    this.navigateToProductSelectionPage=false,
  });

  @override
  Widget build(BuildContext context,ref) {
    return Column(
      children: [
          SvgPicture.asset(
            AppIcons.emptyList,
            height:iconHeight?? 100.h,
          ),
        AutoSizeTextWidget(
          text: S.of(context).thereAreNoLists,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        8.h.verticalSpace,
        AutoSizeTextWidget(
          text: S
              .of(context)
              .aNewWayToManageYourFavoriteProductsYouCanClassifyInYourOwnWay,
          fontSize: 10.8.sp,
          colorText: AppColors.fontColor,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        18.h.verticalSpace,
        DefaultButtonWidget(
          text: S.of(context).createAList,
          height: 34.h,
          width: buttonWidth ?? double.infinity,
          textSize: 10.5.sp,
          onPressed: () {
            if (navigator) {
              Navigator.of(context).pop();
            }
            showModalBottomSheetWidget(
              context: context,
              page: CreateANewListDialogWidget(
                navigateToProductSelectionPage:navigateToProductSelectionPage,
              ),
            );
          },
        ),
        12.h.verticalSpace,
      ],
    );
  }
}
