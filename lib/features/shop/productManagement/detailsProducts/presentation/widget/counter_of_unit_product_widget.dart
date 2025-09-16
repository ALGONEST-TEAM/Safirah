import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/auto_size_text_widget.dart';


class CounterOfUnitProductWidget extends StatefulWidget {
  const CounterOfUnitProductWidget({super.key});

  @override
  State<CounterOfUnitProductWidget> createState() => _CounterOfUnitProductWidgetState();
}

class _CounterOfUnitProductWidgetState extends State<CounterOfUnitProductWidget> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return        Padding(
      padding:  EdgeInsets.only(bottom: 12.sp),
      child: Container(

        width: 80.w,
        height: 22.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.sp),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.sp),
                    bottomRight: Radius.circular(15.sp)),
              ),
              height: 30.h,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (counter > 1) counter--;
                  });
                },
                child: Icon(
                  Icons.remove,
                  size: 19,
                ),
              ),
            ),
            // الرقم
            Expanded(
              child: Center(
                child: AutoSizeTextWidget(
                  text: '$counter',
                  fontWeight: FontWeight.bold,
                  // ),
                ),
              ),
            ),
            // زر التزايد
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.sp),
                    bottomLeft: Radius.circular(15.sp)),
                //border: Border.all(color: Colors.black),
              ),
              height: 30.h,
              child: InkWell(
                onTap: () {
                  setState(() {
                    counter++;
                  });
                },
                child: Icon(
                  Icons.add,
                  size: 19,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
