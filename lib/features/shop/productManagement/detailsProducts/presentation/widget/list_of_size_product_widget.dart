import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/model/product_data.dart';
import '../../data/model/size_data.dart';
import '../state_mangment/riverpod_details.dart';

class ListOfSizeProductWidget extends ConsumerStatefulWidget {
  final ProductData sizeProduct;
  final int? sizeIdOfTheCart;
  final String? sizeNameOfTheCart;

  const ListOfSizeProductWidget({
    super.key,
    required this.sizeProduct,
    this.sizeIdOfTheCart,
    this.sizeNameOfTheCart,
  });

  @override
  ConsumerState<ListOfSizeProductWidget> createState() =>
      _ListOfSizeProductWidgetState();
}

class _ListOfSizeProductWidgetState
    extends ConsumerState<ListOfSizeProductWidget> {
  @override
  void initState() {
    super.initState();
    // أجّل أي تعديل للمزوّد لما بعد أول إطار
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _applyInitialSelection());
  }

  @override
  void didUpdateWidget(covariant ListOfSizeProductWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // لو تغيّرت قيم العربة القادمة من مكان آخر
    if (oldWidget.sizeIdOfTheCart != widget.sizeIdOfTheCart ||
        oldWidget.sizeNameOfTheCart != widget.sizeNameOfTheCart ||
        oldWidget.sizeProduct.id != widget.sizeProduct.id) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _applyInitialSelection());
    }
  }

  void _applyInitialSelection() {
    if (!mounted) return;

    final notifier = ref.read(changePriceProvider(widget.sizeProduct).notifier);

    if (widget.sizeProduct.sizeProduct!.isNotEmpty &&
        widget.sizeProduct.sizeProduct!.length == 1 &&
        widget.sizeIdOfTheCart == null &&
        widget.sizeNameOfTheCart == null) {
      final only = widget.sizeProduct.sizeProduct!.first;
      notifier
        ..setIdSize(only.id!)
        ..setNameSize(only.sizeTypeName);

      if ((widget.sizeProduct.numbersOfProduct?.isNotEmpty ?? false)) {
        Future.microtask(() {
          if (!mounted) return;
          ref
              .read(changeIndexOfSizeProvider(widget.sizeProduct.id!).notifier)
              .state = 0;
        });
      }
      setState(() {});
      return;
    }
    if (widget.sizeIdOfTheCart != null &&
        (widget.sizeNameOfTheCart?.isNotEmpty ?? false)) {
      notifier
        ..setIdSize(widget.sizeIdOfTheCart!)
        ..setNameSize(widget.sizeNameOfTheCart!);
      setState(() {});
    }
  }

  List<SizeData> _resolveSizes(int? indexColor) {
    if ((widget.sizeProduct.colorsProduct?.isNotEmpty ?? false) &&
        indexColor != null) {
      return widget.sizeProduct.colorsProduct![indexColor].sizeData ?? [];
    }
    return widget.sizeProduct.sizeProduct ?? const [];
  }

  @override
  Widget build(BuildContext context) {
    // قراءة فقط لعرض الحالة, دون تعديل
    ref.watch(detailsProvider(widget.sizeProduct.id!));
    final indexColor = ref.watch(changeIndexOfColorImageAndSizeProvider);
    final sizes = _resolveSizes(indexColor);
    final selectedSize = ref
        .read(changePriceProvider(widget.sizeProduct).notifier)
        .getNameSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: "${S.of(context).size}:  $selectedSize",
          colorText: AppColors.fontColor,
          fontWeight: FontWeight.w400,
          fontSize: 12.5.sp,
        ),
        10.verticalSpace,
        Wrap(
          spacing: 10.0.w,
          runSpacing: 6.0,
          children: sizes.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = selectedSize == item.sizeTypeName;

            return GestureDetector(
              onTap: () {
                if (item.numberData!.isEmpty) {
                  if (item.stockStatus == false) {
                    showFlashBarWarring(
                      context: context,
                      message: item.stock ?? '',
                    );
                    return;
                  }
                }
                final priceNotifier =
                    ref.read(changePriceProvider(widget.sizeProduct).notifier);

                if ((widget.sizeProduct.numbersOfProduct?.isNotEmpty ??
                    false)) {
                  priceNotifier
                    ..setNumber('')
                    ..setIdNumber(0);
                  ref
                      .read(changeIndexOfSizeProvider(widget.sizeProduct.id!)
                          .notifier)
                      .state = index;
                }

                priceNotifier
                  ..setNameSize(item.sizeTypeName)
                  ..setIdSize(item.id!);

                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.secondaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.greySwatch.shade200),
                ),
                child: Text(
                  item.sizeTypeName.toString(),
                  style: TextStyle(
                    color:
                        isSelected ? AppColors.whiteColor : AppColors.fontColor,
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// class ListOfSizeProductWidget extends ConsumerStatefulWidget {
//   final ProductData sizeProduct;
//   int? sizeIdOfTheCart;
//   String? sizeNameOfTheCart;
//
//   ListOfSizeProductWidget({
//     super.key,
//     required this.sizeProduct,
//     this.sizeIdOfTheCart,
//     this.sizeNameOfTheCart,
//   });
//
//   @override
//   ConsumerState<ListOfSizeProductWidget> createState() =>
//       _ListOfSizeProductWidgetState();
// }
//
// class _ListOfSizeProductWidgetState
//     extends ConsumerState<ListOfSizeProductWidget> {
//
//   List<SizeData> _resolveSizes(int? indexColor) {
//     if ((widget.sizeProduct.colorsProduct?.isNotEmpty ?? false) &&
//         indexColor != null) {
//       return widget.sizeProduct.colorsProduct![indexColor].sizeData ?? [];
//     }
//     if (widget.sizeProduct.sizeProduct != null &&
//         widget.sizeProduct.sizeProduct!.isNotEmpty) {
//       return widget.sizeProduct.sizeProduct!;
//     }
//     return [];
//   }
//
//   void _autoSelectInitialSize() {
//     var stateNotifier =
//         ref.watch(changePriceProvider(widget.sizeProduct).notifier);
//     if (widget.sizeProduct.sizeProduct!.isNotEmpty &&
//         widget.sizeProduct.sizeProduct!.length == 1 &&
//         widget.sizeIdOfTheCart == null &&
//         widget.sizeNameOfTheCart == null) {
//       stateNotifier.setIdSize(widget.sizeProduct.sizeProduct![0].id!);
//       stateNotifier
//           .setNameSize(widget.sizeProduct.sizeProduct![0].sizeTypeName);
//
//       if (widget.sizeProduct.numbersOfProduct!.isNotEmpty) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ref
//               .read(changeIndexOfSizeProvider(widget.sizeProduct.id!).notifier)
//               .state = 0;
//         });
//       }
//     }
//     if (widget.sizeIdOfTheCart != null &&
//         widget.sizeNameOfTheCart != null &&
//         widget.sizeNameOfTheCart!.isNotEmpty) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (!mounted) return;
//         stateNotifier.setIdSize(widget.sizeIdOfTheCart!);
//         stateNotifier.setNameSize(widget.sizeNameOfTheCart!);
//       });
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ref.watch(detailsProvider(widget.sizeProduct.id!));
//     var indexColor = ref.watch(changeIndexOfColorImageAndSizeProvider);
//     final sizes = _resolveSizes(indexColor);
//     _autoSelectInitialSize();
//     final selectedSize = ref
//         .read(changePriceProvider(widget.sizeProduct).notifier)
//         .getNameSize();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         AutoSizeTextWidget(
//           text: "${S.of(context).size}:  $selectedSize",
//           colorText: AppColors.fontColor,
//           fontWeight: FontWeight.w400,
//           fontSize: 12.5.sp,
//         ),
//         10.verticalSpace,
//         Wrap(
//           spacing: 10.0.w,
//           runSpacing: 6.0,
//           children: sizes
//               .asMap()
//               .map(
//                 (index, item) => MapEntry(
//                   index,
//                   Consumer(builder: (context, ref, child) {
//                     return GestureDetector(
//                       onTap: () {
//                         // if (widget.sizeIdOfTheCart != null &&
//                         //     widget.sizeNameOfTheCart != null) {
//                         //   widget.sizeNameOfTheCart = null;
//                         //   widget.sizeIdOfTheCart = null;
//                         // }
//                         //   widget.sizeNameOfTheCart = null;
//                         //   widget.sizeIdOfTheCart = null;
//                         final priceNotifier = ref.read(
//                             changePriceProvider(widget.sizeProduct).notifier);
//
//                         if (widget.sizeProduct.numbersOfProduct!.isNotEmpty) {
//                           priceNotifier
//                             ..setNumber('')
//                             ..setIdNumber(0);
//
//                           ref
//                               .read(changeIndexOfSizeProvider(
//                                       widget.sizeProduct.id!)
//                                   .notifier)
//                               .state = index;
//                         }
//
//                         priceNotifier
//                           ..setNameSize(item.sizeTypeName)
//                           ..setIdSize(item.id!);
//
//                         setState(() {});
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 13.w,
//                           vertical: 7.h,
//                         ),
//                         decoration: BoxDecoration(
//                           color: selectedSize == item.sizeTypeName
//                               ? AppColors.secondaryColor
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(8.r),
//                           border:
//                               Border.all(color: AppColors.greySwatch.shade200),
//                         ),
//                         child: Text(
//                           item.sizeTypeName.toString(),
//                           style: TextStyle(
//                             color: selectedSize == item.sizeTypeName
//                                 ? AppColors.whiteColor
//                                 : AppColors.fontColor,
//                             fontSize: 12.sp,
//                             fontWeight: selectedSize == item.sizeTypeName
//                                 ? FontWeight.w500
//                                 : FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               )
//               .values
//               .toList(),
//         ),
//       ],
//     );
//   }
// }
