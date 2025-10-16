import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/extension/string.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../detailsProducts/presentation/state_mangment/riverpod_details.dart';
import '../riverpod/reviews_riverpod.dart';
import '../widgets/add_image_button_widget.dart';
import '../widgets/add_rating_and_comment_widget.dart';
import '../widgets/list_of_selected_images_to_add_a_review_widget.dart';
import '../widgets/radio_for_the_right_size_widget.dart';
import '../widgets/show_image_source_widget.dart';

class AddReviewsDialog extends ConsumerStatefulWidget {
  final int orderId;
  final int productId;
  final dynamic colorId;
  final String colorHex;
  final String colorName;
  final int sizeId;
  final String sizeValue;
  final int? numberId;
  final String? numberName;

  const AddReviewsDialog({
    super.key,
    required this.orderId,
    required this.productId,
    required this.colorId,
    required this.colorHex,
    required this.colorName,
    required this.sizeId,
    required this.sizeValue,
    this.numberId,
    this.numberName,
  });

  @override
  ConsumerState<AddReviewsDialog> createState() => _AddReviewsDialogState();
}

class _AddReviewsDialogState extends ConsumerState<AddReviewsDialog> {
  TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  double countEvaluation = 2.5;
  String tempSizeMethodGroupValue = '2';
  List<File> _images = [];

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(addReviewsProvider);
    final parts = <String>[];
    final colorLabel = S.of(context).color;

    if (widget.colorName.isNotEmpty ) {
      parts.add(' $colorLabel ${widget.colorName.toString()}');
    }
    final sizeLabel = S.of(context).size;
    if (widget.sizeValue.isNotEmpty) {
      parts.add('$sizeLabel ${widget.sizeValue}');
    }
    final numLabel = S.of(context).number;
    if ((widget.numberName ?? '').isNotEmpty) {
      parts.add('$numLabel ${widget.numberName}');
    }
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(12.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddRatingAndCommentWidget(
                    commentController: commentController,
                    countEvaluation: countEvaluation,
                    onRatingUpdate: (double rating) {
                      setState(() {
                        countEvaluation = rating;
                      });
                    },
                  ),
                  Row(
                    children: [
                      // if (widget.colorHex.isNotEmpty)
                      //   AutoSizeTextWidget(
                      //     text: "${S.of(context).color}: ",
                      //     fontSize: 11.8.sp,
                      //     colorText: AppColors.fontColor,
                      //   ),
                      if (widget.colorHex.isNotEmpty)
                        Container(
                          height: 12.h,
                          width: 12.w,

                          decoration: BoxDecoration(
                            color: widget.colorHex.toString().toColor(),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      Flexible(
                        child: AutoSizeTextWidget(
                          text: parts.join('  /  '),

                          // text:
                              // " ${widget.colorName.toString()}${widget.colorName.isNotEmpty ? "  -  " : ''}${S.of(context).size}: ${widget.sizeValue.toString()}",
                          fontSize: 11.8.sp,
                          colorText: AppColors.fontColor,
                        ),
                      ),
                    ],
                  ),
                  16.h.verticalSpace,
                  AutoSizeTextWidget(
                    text: S.of(context).doesTheProductSizeFitWell,
                    colorText: AppColors.fontColor,
                    fontSize: 12.sp,
                  ),
                  8.h.verticalSpace,
                  RadioForTheRightSizeWidget(
                    title: S.of(context).small,
                    value: "1",
                    sizeMethodGroupValue: tempSizeMethodGroupValue,
                    onTap: () {
                      setState(() {
                        tempSizeMethodGroupValue = "1";
                      });
                    },
                  ),
                  RadioForTheRightSizeWidget(
                    title: S.of(context).appropriate,
                    value: "2",
                    sizeMethodGroupValue: tempSizeMethodGroupValue,
                    onTap: () {
                      setState(() {
                        tempSizeMethodGroupValue = "2";
                      });
                    },
                  ),
                  RadioForTheRightSizeWidget(
                    title: S.of(context).big,
                    value: "3",
                    sizeMethodGroupValue: tempSizeMethodGroupValue,
                    onTap: () {
                      setState(() {
                        tempSizeMethodGroupValue = "3";
                      });
                    },
                  ),
                  8.h.verticalSpace,
                  AutoSizeTextWidget(
                    text: S.of(context).addPhotos,
                    colorText: AppColors.fontColor,
                    fontSize: 12.sp,
                  ),
                  8.h.verticalSpace,
                  AddImageButtonWidget(
                    showImageSource: ShowImageSourceWidget(
                      images: _images,
                      onImagePicked: (List<File> newImages) {
                        setState(() {
                          _images = newImages;
                        });
                      },
                    ),
                  ),
                  _images.isEmpty
                      ? const SizedBox.shrink()
                      : ListOfSelectedImagesToAddAReviewWidget(images: _images),
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: CheckStateInPostApiDataWidget(
                state: state,
                functionSuccess: () {
                  Navigator.of(context).pop();
                  ref.refresh(getAllReviewsProvider(widget.productId));
                  ref.refresh(detailsProvider(widget.productId));
                },
                bottonWidget: DefaultButtonWidget(
                  text: S.of(context).confirm,
                  height: 39.h,
                  textSize: 13.sp,
                  isLoading: state.stateData == States.loading,
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (isValid) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ref.read(addReviewsProvider.notifier).addReviews(
                            orderId: widget.orderId,
                            productId: widget.productId,
                            colorId: widget.colorId,
                            sizeId: widget.sizeId,
                            comment: commentController.text,
                            evaluation: countEvaluation,
                            proportion: int.parse(tempSizeMethodGroupValue),
                            images: _images,
                            numberId: widget.numberId ?? 0,
                          );
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }
}
