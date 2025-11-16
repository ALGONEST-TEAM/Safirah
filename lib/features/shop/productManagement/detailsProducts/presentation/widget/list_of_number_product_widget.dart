import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/model/number_model.dart';
import '../../data/model/product_data.dart';
import '../state_mangment/riverpod_details.dart';

class ListOfNumberProductWidget extends ConsumerStatefulWidget {
  final ProductData product;
  int? numberIdOfTheCart;
  String? numberOfTheCart;

  ListOfNumberProductWidget({
    super.key,
    required this.product,
    this.numberIdOfTheCart,
    this.numberOfTheCart,
  });

  @override
  ConsumerState<ListOfNumberProductWidget> createState() =>
      _ListOfNumberProductWidgetState();
}

class _ListOfNumberProductWidgetState
    extends ConsumerState<ListOfNumberProductWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _autoSelectTheSelectedNumberFromTheCart());
  }

  @override
  void didUpdateWidget(covariant ListOfNumberProductWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.numberIdOfTheCart != widget.numberIdOfTheCart ||
        oldWidget.numberOfTheCart != widget.numberOfTheCart ||
        oldWidget.product.id != widget.product.id) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => _autoSelectTheSelectedNumberFromTheCart());
    }
  }

  List<NumberModel> _resolveNumbers(int? indexSize, int? indexColor) {
    if (widget.product.numbersOfProduct!.isNotEmpty && indexSize == null) {
      return widget.product.numbersOfProduct!;
    }
    if (indexSize != null && indexColor != null) {
      return widget
          .product.colorsProduct![indexColor].sizeData![indexSize].numberData!;
    }

    return [];
  }

  void _autoSelectTheSelectedNumberFromTheCart() {
    var stateNotifier = ref.watch(changePriceProvider(widget.product).notifier);

    if (widget.numberIdOfTheCart != null &&
        widget.numberOfTheCart != null &&
        widget.numberOfTheCart!.isNotEmpty) {
      stateNotifier.setIdNumber(widget.numberIdOfTheCart!);
      stateNotifier.setNumber(widget.numberOfTheCart!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(detailsProvider(widget.product.id!));
    var indexColor = ref.watch(changeIndexOfColorImageAndSizeProvider);
    var indexSize = ref.watch(changeIndexOfSizeProvider(widget.product.id!));
    final numbers = _resolveNumbers(indexSize, indexColor);
    final currentNumber =
        ref.watch(changePriceProvider(widget.product).notifier).getNumber();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.verticalSpace,
        AutoSizeTextWidget(
          text: "${S.of(context).numbers}:  $currentNumber",
          colorText: AppColors.fontColor,
          fontWeight: FontWeight.w400,
          fontSize: 12.5.sp,
        ),
        10.verticalSpace,
        Wrap(
          spacing: 10.0.w,
          runSpacing: 6.0,
          children: numbers.asMap().entries.map((entry) {
            final item = entry.value;
            return Consumer(builder: (context, ref, child) {
              return GestureDetector(
                onTap: () {
                  if (item.stockStatus ==
                      false) {
                    showFlashBarWarring(
                      context: context,
                      message: item.stock ?? '',
                    );
                    return;
                  }
                  ref.read(changePriceProvider(widget.product).notifier)
                    ..setNumber(item.number!)
                    ..setIdNumber(item.id!);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 13.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: currentNumber == item.number
                        ? AppColors.secondaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.greySwatch.shade200),
                  ),
                  child: Text(
                    item.number.toString(),
                    style: TextStyle(
                      color: currentNumber == item.number
                          ? AppColors.whiteColor
                          : AppColors.fontColor,
                      fontSize: 12.sp,
                      fontWeight: currentNumber == item.number
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                ),
              );
            });
          }).toList(),
        ),
      ],
    );
  }
}
