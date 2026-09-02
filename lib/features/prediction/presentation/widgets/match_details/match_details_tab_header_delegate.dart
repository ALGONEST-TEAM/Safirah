import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchDetailsTabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;

  MatchDetailsTabHeaderDelegate({
    required this.child,
  });

  @override
  double get minExtent => child.preferredSize.height;

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: child,
    );
  }

  @override
  bool shouldRebuild(MatchDetailsTabHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
