import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/network/errors/remote_exception.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/error_widget.dart';
import '../../data/model/section_with_product_data.dart';
import '../../../category/presentation/widgets/home_categories_list_widget.dart';
import 'loading_home_widget.dart';

class CategoryWidget extends StatelessWidget {
  final DataState<SectionAndProductData> state;
  final VoidCallback? refresh;

  const CategoryWidget({
    super.key,
    required this.state,
    this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer(builder: (context, ref, child) {
        if (state.stateData == States.loading) {
          return Padding(
            padding:  EdgeInsets.only(top: 24.h),
            child: const LoadingHomeWidget(),
          );
        } else if (state.stateData == States.loaded ||
            state.stateData == States.loadingMore) {
          return HomeCategoriesList(
            category: state.data.sections![0].category ?? [],
          );
        } else if (state.stateData == States.error) {
          state.stateData = States.initial;
          return Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: ErrorsWidget(
              title:
                  MessageOfErorrApi.getExeptionMessage(state.exception!).first,
              subTitle:
                  MessageOfErorrApi.getExeptionMessage(state.exception!).last,
              onPressed: refresh,
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
