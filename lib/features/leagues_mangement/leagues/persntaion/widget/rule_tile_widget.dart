import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RuleTileWidget extends StatelessWidget {
  const RuleTileWidget({
    super.key,
    required this.text,
    required this.selected,
    required this.onChanged,
  });

  final String text;
  final bool selected;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 11.sp),
      ),
      leading: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Checkbox(
          value: selected,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(color: Color(0xFFCA9A2C), width: 1,strokeAlign: 1),
          ),
          fillColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.selected)
                ? const Color(0xFFCA9A2C)
                : const Color(0xFFFBF8EB);
          }),
          checkColor: const Color(0xFFCA9A2C)
        ),
      ),
    );
  }
}
