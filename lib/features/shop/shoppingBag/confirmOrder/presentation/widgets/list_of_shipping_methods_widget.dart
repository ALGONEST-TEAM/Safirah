// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:reactive_forms/reactive_forms.dart';
// // import '../../../../../../core/helpers/flash_bar_helper.dart';
// // import '../../../../../../core/theme/app_colors.dart';
// // import '../../../../../payment/presentation/riverpod/payment_riverpod.dart';
// // import '../../data/model/delivery_types_model.dart';
// // import 'design_of_shipping_method_data_widget.dart';
// //
// // class ListOfShippingMethodsWidget extends ConsumerStatefulWidget {
// //   final List<DeliveryTypesModel> deliveryTypes;
// //
// //   final FormGroup form;
// //
// //   const ListOfShippingMethodsWidget(
// //       {super.key, required this.deliveryTypes, required this.form});
// //
// //   @override
// //   ConsumerState<ListOfShippingMethodsWidget> createState() =>
// //       _ListOfShippingMethodsWidgetState();
// // }
// //
// // class _ListOfShippingMethodsWidgetState
// //     extends ConsumerState<ListOfShippingMethodsWidget> {
// //   bool _isSanaa(int? v) {
// //     print(v);
// //     if (v == null) return false;
// //     if(v==3){
// //       return true;
// //     }
// //     // final s = v
// //     //     .toLowerCase()
// //     //     .trim()
// //     //     .replaceAll(RegExp(r"[^\p{L}\p{N}]+", unicode: true), "");
// //     // return s.contains('امانة العاصمة') ||
// //     //     s.contains('sanaa') ||
// //     //     s.contains("sanaa") ||
// //     //     s.contains("sana");
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<Object?>(
// //       stream: widget.form.control('city_name').valueChanges,
// //       initialData: widget.form.control('city_name').value,
// //       builder: (context, snapshot) {
// //         return StreamBuilder<Object?>(
// //           stream: widget.form.control('shipping_method_id').valueChanges,
// //           initialData: widget.form.control('shipping_method_id').value,
// //           builder: (context, snapshot) {
// //             final city = widget.form.control('city_id');
// //             final hasAddress = city.valid &&
// //                 city.value != null &&
// //                 city.value.toString().trim().isNotEmpty;
// //             final isSanaa = hasAddress ? _isSanaa(city.value) : false;
// //             final methods = hasAddress
// //                 ? widget.deliveryTypes.where((m) {
// //                   print(m.scope);
// //                     final methodScope = (m.scope) == true;
// //                     return isSanaa ? methodScope : !methodScope;
// //                   }).toList()
// //                 : widget.deliveryTypes;
// //
// //             return ListView.separated(
// //               physics: const NeverScrollableScrollPhysics(),
// //               shrinkWrap: true,
// //               itemCount: methods.length,
// //               itemBuilder: (context, index) {
// //                 final item = methods[index];
// //
// //                 return DesignOfShippingMethodDataWidget(
// //                   deliveryData: item,
// //                   shippingMethodGroupValue:
// //                       widget.form.control('shipping_method_id').value.toString(),
// //                   onPressed: () {
// //                     if (!hasAddress) {
// //                       showFlashBarWarring(
// //                           context: context,
// //                           message: 'يرجى تحديد العنوان لتحديد وسيلة الشحن');
// //                       return;
// //                     }
// //
// //                     widget.form.control('shipping_method_id').updateValue(item.id);
// //                     widget.form.control('shipping_price').updateValue(item.cost);
// //                     refreshPaymentExecutionState(ref);
// //                   },
// //                 );
// //               },
// //               separatorBuilder: (context, index) => Divider(
// //                 color: AppColors.fontColor2.withValues(alpha: 0.2),
// //                 thickness: 0.5.h,
// //                 height: 14.h,
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:reactive_forms/reactive_forms.dart';
//
// import '../../../../../../core/helpers/flash_bar_helper.dart';
// import '../../../../../../core/theme/app_colors.dart';
// import '../../../../../payment/presentation/riverpod/payment_riverpod.dart';
// import '../../data/model/delivery_types_model.dart';
// import 'design_of_shipping_method_data_widget.dart';
//
// class ListOfShippingMethodsWidget extends ConsumerStatefulWidget {
//   final List<DeliveryTypesModel> deliveryTypes;
//   final FormGroup form;
//
//   const ListOfShippingMethodsWidget({
//     super.key,
//     required this.deliveryTypes,
//     required this.form,
//   });
//
//   @override
//   ConsumerState<ListOfShippingMethodsWidget> createState() =>
//       _ListOfShippingMethodsWidgetState();
// }
//
// class _ListOfShippingMethodsWidgetState
//     extends ConsumerState<ListOfShippingMethodsWidget> {
//   /// معرف مدينة صنعاء
//   // static const int sanaaCityId = 3;
//   //
//   // /// معرف وسيلة الشحن الخاصة بصنعاء
//   // static const int sanaaShippingMethodId = 3;
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<Object?>(
//       stream: widget.form.control('city_id').valueChanges,
//       initialData: widget.form.control('city_id').value,
//       builder: (context, citySnapshot) {
//         return StreamBuilder<Object?>(
//           stream: widget.form.control('shipping_method_id').valueChanges,
//           initialData: widget.form.control('shipping_method_id').value,
//           builder: (context, shippingSnapshot) {
//             final city = widget.form.control('city_id');
//
//             final hasCity =
//                 city.valid && city.value != null;
//
//             final isSanaa = city.value != 3;
//
//             final methods = !hasCity
//                 ? widget.deliveryTypes
//                 : widget.deliveryTypes.where((method) {
//               final isSanaaMethod =
//                   method.id == 3;
//
//               return isSanaa
//                   ? isSanaaMethod
//                   : !isSanaaMethod;
//             }).toList();
//
//             return ListView.separated(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: methods.length,
//               separatorBuilder: (_, __) => Divider(
//                 color: AppColors.fontColor2.withValues(alpha: 0.2),
//                 thickness: 0.5.h,
//                 height: 14.h,
//               ),
//               itemBuilder: (context, index) {
//                 final method = methods[index];
//
//                 return DesignOfShippingMethodDataWidget(
//                   deliveryData: method,
//                   shippingMethodGroupValue:
//                   widget.form
//                       .control('shipping_method_id')
//                       .value
//                       ?.toString() ??
//                       '',
//                   onPressed: () {
//                     if (!hasCity) {
//                       showFlashBarWarring(
//                         context: context,
//                         message:
//                         'يرجى تحديد المدينة أولاً',
//                       );
//                       return;
//                     }
//
//                     widget.form
//                         .control('shipping_method_id')
//                         .updateValue(method.id);
//
//                     widget.form
//                         .control('shipping_price')
//                         .updateValue(method.cost);
//
//                     refreshPaymentExecutionState(ref);
//                   },
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../payment/presentation/riverpod/payment_riverpod.dart';
import '../../data/model/delivery_types_model.dart';
import '../riverpod/confirm_order_riverpod.dart';
import 'design_of_shipping_method_data_widget.dart';

class ListOfShippingMethodsWidget extends ConsumerStatefulWidget {
  final List<DeliveryTypesModel> deliveryTypes;
  final FormGroup form;

  const ListOfShippingMethodsWidget({
    super.key,
    required this.deliveryTypes,
    required this.form,
  });

  @override
  ConsumerState<ListOfShippingMethodsWidget> createState() =>
      _ListOfShippingMethodsWidgetState();
}

class _ListOfShippingMethodsWidgetState
    extends ConsumerState<ListOfShippingMethodsWidget> {
  bool get _hasAddress {
    final addressId = widget.form.control('address_id').value;

    return addressId != null &&
        addressId.toString().trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final deliveryState = ref.watch(fetchDeliveryProvider( widget.form.control('address_id').value??0));

    return StreamBuilder<Object?>(
      stream: widget.form.control('address_id').valueChanges,
      initialData: widget.form.control('address_id').value,
      builder: (context, addressSnapshot) {
        return StreamBuilder<Object?>(
          stream: widget.form.control('shipping_method_id').valueChanges,
          initialData: widget.form.control('shipping_method_id').value,
          builder: (context, shippingSnapshot) {
            final methods = deliveryState.data;

            if (methods.isEmpty) {
              return const SizedBox.shrink();
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: methods.length,
              separatorBuilder: (_, __) => Divider(
                color: AppColors.fontColor2.withValues(alpha: 0.2),
                thickness: 0.5.h,
                height: 14.h,
              ),
              itemBuilder: (context, index) {
                final method = methods[index];

                return DesignOfShippingMethodDataWidget(
                  deliveryData: method,
                  shippingMethodGroupValue:
                  widget.form
                      .control('shipping_method_id')
                      .value
                      ?.toString() ??
                      '',
                  onPressed: () {
                    if (!_hasAddress) {
                      showFlashBarWarring(
                        context: context,
                        message: 'يرجى تحديد عنوان التوصيل أولاً',
                      );
                      return;
                    }

                    widget.form
                        .control('shipping_method_id')
                        .updateValue(method.id);

                    widget.form
                        .control('shipping_price')
                        .updateValue(method.cost);

                    refreshPaymentExecutionState(ref);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}