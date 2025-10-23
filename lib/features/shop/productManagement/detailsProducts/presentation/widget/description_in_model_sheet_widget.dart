import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/details_product_data.dart';

class DescriptionInModelSheetWidget extends StatelessWidget {
  const DescriptionInModelSheetWidget(
      {super.key, required this.detailsProduct});

  final List<DetailsProductData> detailsProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           AutoSizeTextWidget(
            text: "الوصف",
            fontSize: 14.sp,
          ),
          const Divider(color: Color(0xffF6F6F6)),
          SingleChildScrollView(
            child: Column(
              children: detailsProduct.map((item) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.detailName!,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ),
                      20.verticalSpace,
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            item.detailValue!,
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // ListView.builder(
          //   shrinkWrap: true,
          //   physics:const NeverScrollableScrollPhysics(),
          //   itemCount: detailsProduct.length,
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding:  EdgeInsets.all(4.0.sp),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Row(
          //             children: [
          //               Row(
          //                // mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   AutoSizeTextWidget(text: detailsProduct[index].detailName!),
          //                  // AutoSizeTextWidget(text: detailsProduct[index].detailValue!),
          //
          //                 ],
          //               ),
          //               20.horizontalSpace,
          //               Row(
          //                 //mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   // AutoSizeTextWidget(text: detailsProduct[index].detailName!),
          //                   // 16.horizontalSpace,
          //                   AutoSizeTextWidget(text: detailsProduct[index].detailValue!),
          //
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
