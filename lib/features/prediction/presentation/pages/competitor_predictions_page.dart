import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/main_app_bar_widget.dart';
import '../widgets/competitor_prediction_list_widget.dart';

class CompetitorPredictionsPage extends StatelessWidget {
  final int competitorId;
  final String competitorName;

  const CompetitorPredictionsPage({
    super.key,
    required this.competitorId,
    required this.competitorName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: MainAppBarWidget(title: competitorName),
      body: SafeArea(
        top: false,
        child: CompetitorPredictionListWidget(
          competitorId: competitorId,
        ),
      ),
    );
  }
}
