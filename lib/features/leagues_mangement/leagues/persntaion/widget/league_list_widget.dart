import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../riverpod/riverpod.dart';
import 'league_card_widget.dart';

class LeaguesListWidget extends ConsumerWidget {
  const LeaguesListWidget({super.key, required this.isPrivate});

  final bool isPrivate;

  @override
  Widget build(BuildContext context, ref) {
    final leagueState = ref.watch(leaguesByPrivacyProvider(isPrivate));
    return CheckStateInGetApiDataWidget(
      state: leagueState,
      widgetOfData: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        itemBuilder: (_, i) => LeagueCardWidget(
          leagueModel: leagueState.data[i],
          imageUrl:
          'https://images.unsplash.com/photo-1517649763962-0c623066013b?q=80&w=1200&auto=format&fit=crop',
        ),
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemCount: leagueState.data.length,
      ),
    );
  }
}
