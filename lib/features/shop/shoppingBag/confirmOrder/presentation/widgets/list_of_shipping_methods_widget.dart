import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../data/model/delivery_types_model.dart';
import '../riverpod/confirm_order_riverpod.dart';
import 'design_of_shipping_method_data_widget.dart';

class ListOfShippingMethodsWidget extends ConsumerStatefulWidget {
  final List<DeliveryTypesModel> deliveryTypes;

  final FormGroup form;

  const ListOfShippingMethodsWidget(
      {super.key, required this.deliveryTypes, required this.form});

  @override
  ConsumerState<ListOfShippingMethodsWidget> createState() =>
      _ListOfShippingMethodsWidgetState();
}

class _ListOfShippingMethodsWidgetState
    extends ConsumerState<ListOfShippingMethodsWidget> {
  bool _isSanaa(String? v) {
    if (v == null) return false;
    final s = v
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r"[^\p{L}\p{N}]+", unicode: true), "");
    return s.contains('صنعاء') ||
        s.contains('sanaa') ||
        s.contains("sanaa") ||
        s.contains("sana");
  }

  @override
  Widget build(BuildContext context) {
    final city = widget.form.control('city_name');
    final hasAddress = city.valid &&
        city.value != null &&
        city.value.toString().trim().isNotEmpty;
    final isSanaa = hasAddress ? _isSanaa(city.value.toString()) : false;
    final methods = hasAddress
        ? widget.deliveryTypes.where((m) {
            final methodScope = (m.scope) == true;
            return isSanaa ? methodScope : !methodScope;
          }).toList()
        : widget.deliveryTypes;
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: methods.length,
      itemBuilder: (context, index) {
        final item = methods[index];

        return DesignOfShippingMethodDataWidget(
          deliveryData: item,
          shippingMethodGroupValue:
              widget.form.control('shipping_method_id').value.toString(),
          onPressed: () {
            if (!hasAddress) {
              showFlashBarWarring(
                  context: context,
                  message: 'يرجى تحديد العنوان لتحديد وسيلة الشحن');
              return;
            }
            setState(() {
              widget.form.control('shipping_method_id').value = item.id;
              widget.form.control('shipping_price').value = item.cost;

              ref.refresh(confirmOrderProvider.notifier);
            });
          },
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: AppColors.fontColor2.withValues(alpha: 0.2),
        thickness: 0.5.h,
        height: 14.h,
      ),
    );
  }
}
