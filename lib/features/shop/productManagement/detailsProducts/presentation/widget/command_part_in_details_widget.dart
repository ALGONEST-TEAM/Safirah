import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/product/product_list_widget.dart';



class CommandPartInDetailsWidget extends StatelessWidget {
  const CommandPartInDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.sp),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  AutoSizeTextWidget(
                    text: 'التعليقات (1000)',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  Spacer(),
                  AutoSizeTextWidget(
                    text: 'عرض الكل',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    colorText: Color(0xffBCBCBC),
                  ),
                ],
              ),
              10.verticalSpace,
              Container(
                padding: EdgeInsets.only(top: 10.sp),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Color(0xffBCBCBC)),
                    top: BorderSide(color: Color(0xffBCBCBC)),
                    right: BorderSide(color: Color(0xffBCBCBC)),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10.sp, right: 10.sp, top: 10.sp),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const AutoSizeTextWidget(
                                text: '2.20',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              4.horizontalSpace,
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15.sp,
                              ),
                            ],
                          ),
                          12.verticalSpace,
                          const Divider(color: Color(0xffF6F6F6)),
                          12.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeTextWidget(
                                text: 'القصة بشكل عام',
                                fontSize: 14,
                              ),
                              4.horizontalSpace,
                              const AutoSizeTextWidget(
                                text: 'صغير',
                                fontSize: 14,
                              ),
                              4.horizontalSpace,
                              const AutoSizeTextWidget(
                                text: 'متوسط',
                                fontSize: 14,
                              ),
                              4.horizontalSpace,
                              const AutoSizeTextWidget(
                                text: 'كبير',
                                fontSize: 14,
                              ),
                              4.horizontalSpace,
                            ],
                          ),
                        ],
                      ),
                    ),
                    18.verticalSpace,
                    Container(
                      height: 50.h,
                      color: const Color(0xffF6F6F6),
                      padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                      child: Row(
                        children: [
                          AutoSizeTextWidget(
                            text: 'تقييمات محلية',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          5.horizontalSpace,
                          Row(
                            children: [
                              AutoSizeTextWidget(
                                text: '2.20',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              4.horizontalSpace,
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12.sp,
                              ),
                            ],
                          ),
                          Spacer(),
                          AutoSizeTextWidget(
                            text: 'عرض >',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            colorText: Color(0xffBCBCBC),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      AutoSizeTextWidget(
                        text: 'حسين نزار الاشول',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      6.horizontalSpace,
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15.sp,
                          ),
                        ],
                      ),
                      Spacer(),
                      AutoSizeTextWidget(
                        text: '10-10-2020',
                        fontSize: 12,
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  AutoSizeTextWidget(
                    text:
                        'ستان مناسبات حفلات لإطلالة أنثوية متألق مطرزة بالدانتيل بدون أكتاف. كوني مختلفة و متألقة بهذا الفستان ذو التصميم الإبداعي الفخم. فستان منفوخ وواسع منقوش',
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    maxLines: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 27,
                        ),
                        onPressed: () {},
                      ),
                      AutoSizeTextWidget(
                        text: '220',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(color: Color(0xffF6F6F6)),
              16.verticalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      AutoSizeTextWidget(
                        text: 'حسين نزار الاشول',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      6.horizontalSpace,
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15.sp,
                          ),
                        ],
                      ),
                      Spacer(),
                      AutoSizeTextWidget(
                        text: '10-10-2020',
                        fontSize: 12,
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  AutoSizeTextWidget(
                    text:
                    'ستان مناسبات حفلات لإطلالة أنثوية متألق مطرزة بالدانتيل بدون أكتاف. كوني مختلفة و متألقة بهذا الفستان ذو التصميم الإبداعي الفخم. فستان منفوخ وواسع منقوش',
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    maxLines: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 27,
                        ),
                        onPressed: () {},
                      ),
                      AutoSizeTextWidget(
                        text: '220',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        2.verticalSpace,
        ProductListWidget(product: [],),
      ],
    );
  }
}
