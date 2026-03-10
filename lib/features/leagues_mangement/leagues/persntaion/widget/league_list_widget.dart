import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../riverpod/riverpod.dart';
import 'league_card_widget.dart';

class LeaguesListWidget extends ConsumerStatefulWidget {
  const LeaguesListWidget({super.key, required this.isPrivate});

  final bool isPrivate;

  @override
  ConsumerState<LeaguesListWidget> createState() => _LeaguesListWidgetState();
}

class _LeaguesListWidgetState extends ConsumerState<LeaguesListWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadMoreIfNeeded() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    try {
      await ref
          .read(leaguesByPrivacyProvider(widget.isPrivate).notifier)
          .getDataBookingType(moreData: true);
    } finally {
      _isLoadingMore = false;
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final reachedBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 24;

    if (reachedBottom) {
      _loadMoreIfNeeded();
    }
  }

  @override
  Widget build(BuildContext context) {
    final leagueState = ref.watch(leaguesByPrivacyProvider(widget.isPrivate));
    final items = leagueState.data.data;

    return CheckStateInGetApiDataWidget(
      state: leagueState,
      widgetOfData: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        itemBuilder: (_, i) => LeagueCardWidget(
          leagueModel: items[i],
          imageUrl:items[i].logoPath??'',
        ),
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemCount: items.length,
      ),
    );
  }
}
