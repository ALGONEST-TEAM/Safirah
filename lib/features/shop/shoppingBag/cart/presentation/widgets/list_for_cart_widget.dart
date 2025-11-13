import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../productManagement/detailsProducts/presentation/page/details_page.dart';
import '../riverpod/cart_riverpod.dart';
import 'cart_card_widget.dart';

class ListForCartWidget extends ConsumerStatefulWidget {
  const ListForCartWidget({super.key});

  @override
  ConsumerState<ListForCartWidget> createState() => _ListForCartWidgetState();
}

class _ListForCartWidgetState extends ConsumerState<ListForCartWidget> {
  int loadingId = 0;
  bool delete = false;

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getAllCartProvider);
    var cartStateNotifier = ref.watch(cartProvider.notifier);
    var cartState = ref.watch(cartProvider);

    return CheckStateInPostApiDataWidget(
      state: cartState,
      hasMessageSuccess: false,
      functionSuccess: () {
        setState(() {
          if (delete) {
            delete = false;
          } else {
            ref.read(cartProductProvider(loadingId).notifier).updateProduct(
                  ref
                      .read(cartProductProvider(loadingId))
                      .updateCartProduct(ref.read(cartProvider).data),
                );
            final index = state.data.indexWhere((item) => item.id == loadingId);
            if (index != -1) {
              state.data[index] =
                  state.data[index].updateCartProduct(cartState.data);
            }
          }
        });
      },
      bottonWidget: ListView.builder(
        itemCount: state.data.length,
        padding: EdgeInsets.all(12.sp),
        itemBuilder: (context, index) {
          index = state.data.length - 1 - index;
          var item = state.data[index];
          return GestureDetector(
            onTap: () {
              navigateTo(
                context,
                DetailsPage(
                  idProduct: item.productId!,
                  name: item.productName.toString(),
                  price: item.price,
                  image: [item.images!],
                ),
              );
            },
            child: CartCardWidget(
              productId: item.id,
              loadingId: loadingId,
              onDelete: () {
                setState(() {
                  loadingId = item.id;
                  delete = true;
                });
                cartStateNotifier.deleteAProductFromTheCart(
                    id: item.id, ref: ref);
              },
              onUpdateQuantity: (int newQuantity) {
                setState(
                  () {
                    loadingId = item.id;

                    cartStateNotifier.updateCart(
                      id: item.id,
                      prodectId: item.productId!,
                      colorId: item.colorId,
                      sizeId: item.sizeId!,
                      price: item.price.toString(),
                      quantity: newQuantity,
                      numberId: item.numberId,
                      isPrintable: item.isPrintable!,
                    );
                  },
                );
              },
              onCancelPrinting: () {
                setState(() {
                  loadingId = item.id;
                  delete = false;
                });
                cartStateNotifier.updateCart(
                  id: item.id,
                  prodectId: item.productId!,
                  colorId: item.colorId,
                  sizeId: item.sizeId!,
                  price: item.price.toString(),
                  quantity: item.quantity!,
                  numberId: item.numberId,
                  isPrintable: 0,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
