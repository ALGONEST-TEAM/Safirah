import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../data/model/product_data.dart';
import '../state_mangment/riverpod_details.dart';
import 'counter_of_unit_product_widget.dart';

class ListOfSizeProductWidget extends ConsumerStatefulWidget {
  const ListOfSizeProductWidget({super.key, required this.sizeProduct});

  final ProductData sizeProduct;

  @override
  _ListOfSizeProductWidgetState createState() =>
      _ListOfSizeProductWidgetState();
}

class _ListOfSizeProductWidgetState
    extends ConsumerState<ListOfSizeProductWidget> {
  String? selectedSize;

  void _autoSelectSingleSize() {
    var stateNotifier =
        ref.watch(changePriceProvider(widget.sizeProduct).notifier);
    if (widget.sizeProduct.sizeProduct!.isNotEmpty &&
        widget.sizeProduct.sizeProduct!.length == 1) {
      stateNotifier.setIdSize(widget.sizeProduct.sizeProduct![0].id!);
      stateNotifier
          .setNameSize(widget.sizeProduct.sizeProduct![0].sizeTypeName);

      selectedSize = widget.sizeProduct.sizeProduct![0].sizeTypeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.sizeProduct.measuringType!.isNotEmpty &&
                widget.sizeProduct.measuringType![0] == "unit"
            ? const CounterOfUnitProductWidget()
            : const SizedBox(),
        Wrap(
          spacing: 10.0.w,
          runSpacing: 6.0,
          children: widget.sizeProduct.sizeProduct!
              .map(
                (item) => Consumer(builder: (context, ref, child) {
                  _autoSelectSingleSize();
                  var state =
                      ref.watch(detailsProvider(widget.sizeProduct.id!));

                  return GestureDetector(
                    onTap: () {
                      ref
                          .watch(
                              changePriceProvider(widget.sizeProduct).notifier)
                          .setNameSize(item.sizeTypeName);
                      ref
                          .read(
                              changePriceProvider(widget.sizeProduct).notifier)
                          .setIdSize(item.id!);

                      setState(() {
                        selectedSize = item.sizeTypeName;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 13.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: selectedSize == item.sizeTypeName
                            ? AppColors.secondaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border:
                            Border.all(color: AppColors.greySwatch.shade200),
                      ),
                      child: Text(
                        item.sizeTypeName.toString(),
                        style: TextStyle(
                          color: selectedSize == item.sizeTypeName
                              ? AppColors.whiteColor
                              : AppColors.fontColor,
                          fontSize: 12.sp,
                          fontWeight: selectedSize == item.sizeTypeName
                              ? FontWeight.w500
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }),
              )
              .toList(),
        ),
      ],
    );
  }
}
