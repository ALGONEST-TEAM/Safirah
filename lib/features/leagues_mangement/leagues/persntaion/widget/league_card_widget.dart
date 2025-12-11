import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../data/model/league_model.dart';
import '../page/details_league_widget.dart';
import 'league_card_image_widget.dart';
import 'league_card_info_widget.dart';

class LeagueCardWidget extends StatelessWidget {
  final LeagueModel leagueModel;
  final String imageUrl;

  const LeagueCardWidget({
    super.key,
    required this.leagueModel,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    const cardBg = Colors.white;

    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          navigateTo(
            context,
            DetailsLeagueWidget(
              leagueId: leagueModel.id ?? 0,
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12.r),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              LeagueCardImageWidget(
                leagueModel: leagueModel,
                fallbackImageUrl: imageUrl,
              ),
              LeagueCardInfoWidget(leagueModel: leagueModel, cardBg: cardBg),
            ],
          ),
        ),
      ),
    );
  }
}


