import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/authorization/presentation/riverpod/authorization_providers.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../data/model/league_model.dart';
import '../page/details_league_user_page.dart';
import '../page/details_league_widget.dart';
import 'league_card_image_widget.dart';
import 'league_card_info_widget.dart';

class LeagueCardWidget extends ConsumerWidget {
  final LeagueModel leagueModel;
  final String imageUrl;

  const LeagueCardWidget({
    super.key,
    required this.leagueModel,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const cardBg = Colors.white;

    final canEditAsync = ref.watch(canEditLeagueProvider(leagueModel.syncId));
    final canEdit = canEditAsync.asData?.value ?? false;

    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          final page = canEdit
              ? DetailsLeagueWidget(leagueSyncId: leagueModel.syncId)
              : (leagueModel.canWatch==false?DetailsLeagueUserPage(leagueSyncId: leagueModel.syncId)
                  : DetailsLeagueWidget(leagueSyncId: leagueModel.syncId));

          navigateTo(context, page);
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
