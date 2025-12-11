import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/leagues_mangement/leagues/persntaion/widget/rule_tile_widget.dart';
import '../../data/model/rule_league_model.dart';

class RulesListSectionWidget extends StatelessWidget {
  const RulesListSectionWidget({
    super.key,
    required this.rules,
    required this.onToggle,
    this.height,
  });

  final List<RuleUIModel> rules; // أو نوع الـ UI لديك
  final void Function(int index) onToggle;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height ?? 220).h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListView.builder(
        itemCount: rules.length,
        itemBuilder: (context, index) {
          final rule = rules[index];
          return RuleTileWidget(
            text: rule.rule,
            selected: rule.selected,
            onChanged: (_) => onToggle(index),
          );
        },
      ),
    );
  }
}
