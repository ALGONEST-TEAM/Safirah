import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/category_data.dart';
import 'home_category_widget.dart';

class HomeCategoriesList  extends ConsumerWidget {
  const HomeCategoriesList (
      {super.key, required this.category});

  final List<CategoryData>? category;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w)
              .copyWith(bottom: 8.h,top: 2.h),
          child: AutoSizeTextWidget(
            text: S.of(context).categories,
            colorText: AppColors.fontColor,
            fontSize: 11.3.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 42.h,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding:
                EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 12.h),
            itemCount: category!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  HomeCategoryWidget(
                    idCategory: category![index].id!,
                    name: category![index].name!,
                    image: category![index].image ??
                        'https://eyess.cc/?seraph_accel_gci=wp-content%2Fuploads%2F2019%2F07%2F2138-1.jpg&n=Flq38TbBQfHfEB8rSZ0XQ',
                  ),
                  12.w.horizontalSpace,
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
// class ListToDisplayCategoriesOnTheHomeWidget extends StatelessWidget {
//   const ListToDisplayCategoriesOnTheHomeWidget({
//     super.key,
//     required this.category,
//     required this.t, // 0..1
//   });
//
//   final List<CategoryData> category;
//   final double t;
//
//   @override
//   Widget build(BuildContext context) {
//     // قيَم تتدرّج مع t
//     final double titleFont = lerpDouble(10.sp, 12.sp, t)!;
//     final double rowHeight = lerpDouble(40.h, 48.h, t)!;
//     // final double hPad = lerpDouble(10.w, 14.w, t)!;
//     // final double vPad = lerpDouble(4.h, 8.h, t)!;
//
//     return SizedBox(
//       height: rowHeight,
//       width: double.infinity,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         padding: EdgeInsets.symmetric(horizontal: 14.w)
//             .copyWith(bottom: 12.h),
//         itemCount: category.length,
//         separatorBuilder: (_, __) => SizedBox(width: 12.w),
//         itemBuilder: (context, index) {
//           final c = category[index];
//           return CircleCardForCategoriesWidget(
//             idCategory: c.id!,
//             name: c.name ?? '',
//             image: c.image ??
//                 'https://eyess.cc/?seraph_accel_gci=wp-content%2Fuploads%2F2019%2F07%2F2138-1.jpg&n=Flq38TbBQfHfEB8rSZ0XQ',
//             t: t,
//           );
//         },
//       ),
//     );
//   }
// }
// class ListToDisplayCategoriesOnTheHomeHeaderWidget extends SliverPersistentHeaderDelegate {
//   ListToDisplayCategoriesOnTheHomeHeaderWidget({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.builder, // يبني الـ UI حسب t (0..1)
//     this.backgroundColor,
//   }) : assert(maxHeight >= minHeight);
//
//   final double minHeight;
//   final double maxHeight;
//   final Color? backgroundColor;
//
//   /// t من 0 (مصغّر/مثبّت) إلى 1 (متمدّد/أعلى الصفحة)
//   final Widget Function(double t) builder;
//
//   @override
//   double get minExtent => minHeight;
//
//   @override
//   double get maxExtent => maxHeight;
//
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     final total = (maxExtent - minExtent);
//     final clamped = (total - shrinkOffset).clamp(0.0, total);
//     final t = total == 0 ? 0.0 : (clamped / total); // 0..1
//
//     // مهم: توسعة المحتوى ليملأ كامل مساحة السليفر لتفادي layoutExtent/paintExtent errors
//     return SizedBox.expand(
//       child: Material(
//         color: backgroundColor ??
//             Theme.of(context).appBarTheme.backgroundColor ??
//             Colors.transparent,
//         child: builder(t),
//       ),
//     );
//   }
//
//   @override
//   bool shouldRebuild(covariant ListToDisplayCategoriesOnTheHomeHeaderWidget old) {
//     return minHeight != old.minHeight ||
//         maxHeight != old.maxHeight ||
//         backgroundColor != old.backgroundColor ||
//         builder != old.builder;
//   }
// }