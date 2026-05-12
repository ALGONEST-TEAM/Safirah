import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/state/data_state.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/logo_shimmer_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../data/model/awards_model.dart';
import '../riverpod/prediction_riverpod.dart';

class AwardsWidget extends ConsumerWidget {
  const AwardsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(awardsProvider);

    return CheckStateInGetApiDataWidget(
      state: state,
      refresh: () => ref.invalidate(awardsProvider),
      widgetOfLoading: const LogoShimmerWidget(),
      widgetOfData: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primaryColor,
        onRefresh: () async {
          ref.invalidate(awardsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(12.sp).copyWith(bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AwardsScopeToggle(data: state.data),
              12.h.verticalSpace,
              _AwardsPrizesSection(data: state.data),
            ],
          ),
        ),
      ),
    );
  }
}

class _AwardsScopeToggle extends ConsumerWidget {
  const _AwardsScopeToggle({required this.data});

  final AwardsData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(awardsScopeProvider);
    final periods = data.availablePeriods;
    final selectedScope = periods.any((item) => item.name == current)
        ? current
        : data.scope;

    return Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          for (int i = 0; i < periods.length; i++) ...[
            Expanded(
              child: _ScopeButton(
                label: periods[i].label,
                selected: selectedScope == periods[i].name,
                onTap: () async {
                  if (selectedScope == periods[i].name) return;
                  ref.read(awardsScopeProvider.notifier).state = periods[i].name;

                  if (data.scopeDataFor(periods[i].name) != null) return;

                  ref.read(awardsScopeRefreshProvider.notifier).state =
                      const RefreshState(status: RefreshStatus.loading);

                  final error = await ref
                      .read(awardsProvider.notifier)
                      .ensureScopeLoaded(periods[i].name);

                  ref.read(awardsScopeRefreshProvider.notifier).state = error == null
                      ? RefreshState.idle()
                      : RefreshState(
                          status: RefreshStatus.error,
                          exception: error is Exception ? null : null,
                        );
                },
              ),
            ),
            if (i != periods.length - 1) 8.w.horizontalSpace,
          ],
        ],
      ),
    );
  }
}

class _ScopeButton extends StatelessWidget {
  const _ScopeButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 42.h,
        decoration: BoxDecoration(
          color: selected ? AppColors.secondaryColor : AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: selected
                ? AppColors.secondaryColor
                : AppColors.greySwatch.shade200,
          ),
        ),
        alignment: Alignment.center,
        child: AutoSizeTextWidget(
          text: label,
          fontSize: 12.sp,
          colorText: selected ? Colors.white : AppColors.secondaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _AwardsPrizesSection extends StatelessWidget {
  const _AwardsPrizesSection({required this.data});

  final AwardsData data;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final current = ref.watch(awardsScopeProvider);
        final scopeRefresh = ref.watch(awardsScopeRefreshProvider);
        final selectedScopeData = data.scopeDataFor(current) ?? data.selectedScopeData;
        final isLoadingCurrentScope =
            data.scopeDataFor(current) == null && scopeRefresh.status == RefreshStatus.loading;

        if (isLoadingCurrentScope) {
          return const LogoShimmerWidget();
        }

        final topThree = selectedScopeData?.items ?? data.items;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text:
                  'كل مركز يعرض جائزته بشكل مباشر لتعرف ما الذي ستحصل عليه عند الفوز.',
              fontSize: 10.8.sp,
              colorText: AppColors.fontColor2,
              maxLines: 3,
            ),
            12.h.verticalSpace,
            for (int i = 0; i < topThree.length; i++) ...[
              _AwardRankCard(item: topThree[i]),
              if (i != topThree.length - 1) 12.h.verticalSpace,
            ],
          ],
        );
      },
    );
  }
}

class _AwardRankCard extends StatelessWidget {
  const _AwardRankCard({
    required this.item,
  });

  static final BorderRadius _cardBorderRadius = BorderRadius.circular(14.r);

  final AwardPrizeData item;

  @override
  Widget build(BuildContext context) {
    final cardHeight = item.prizeDetails.trim().isNotEmpty ? 120.h : 115.h;
    final accent = AppColors.secondaryColor;
    final primaryTextColor = AppColors.fontColor;
    final secondaryTextColor = AppColors.fontColor2;
    final badgeColor = accent.withValues(alpha: .12);
    final badgeTextColor = accent;
    final badgeBorderColor = accent.withValues(alpha: .18);
    final borderColor = AppColors.greySwatch.shade200;

    return SizedBox(
      height: cardHeight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: _cardBorderRadius,

        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: _cardBorderRadius,
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PrizeImageBox(item: item, accent: accent),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                  vertical: 10.sp,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            color: badgeColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: badgeBorderColor),
                          ),
                          alignment: Alignment.center,
                          child: AutoSizeTextWidget(
                            text: item.rank.toString(),
                            fontSize: 11.5.sp,
                            colorText: badgeTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        6.w.horizontalSpace,
                        Expanded(
                          child: AutoSizeTextWidget(
                            text: _rankTitle(item.rank),
                            fontSize: 12.sp,
                            colorText: primaryTextColor,
                            fontWeight: FontWeight.w700,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    8.h.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      child: AutoSizeTextWidget(
                        text: item.prizeHeadline,
                        fontSize: 12.sp,
                        colorText: primaryTextColor,
                        fontWeight: FontWeight.w700,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    if (item.prizeDetails.trim().isNotEmpty) ...[
                      6.h.verticalSpace,
                      SizedBox(
                        width: double.infinity,
                        child: AutoSizeTextWidget(
                          text: item.prizeDetails,
                          fontSize: 10.sp,
                          colorText: secondaryTextColor,
                          maxLines: 3,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _rankTitle(int rank) {
    switch (rank) {
      case 1:
        return 'المركز الأول';
      case 2:
        return 'المركز الثاني';
      case 3:
        return 'المركز الثالث';
      default:
        return 'مركز';
    }
  }
}

class _PrizeImageBox extends StatelessWidget {
  const _PrizeImageBox({
    required this.item,
    required this.accent,
  });

  final AwardPrizeData item;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('award-image-${item.rank}'),
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.r),
          bottomLeft: Radius.circular(14.r),
        ),
        border: Border(
          right: BorderSide(
            color: Colors.white.withValues(alpha: .9),
            width: 1,
          ),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child:  LayoutBuilder(
              builder: (context, constraints) {
                return OnlineImagesWidget(
                  imageUrl: item.imageUrl,
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  fit: BoxFit.cover,
                  borderRadius: 0,
                  backgroundColor: Colors.transparent,
                );
              },
            )

    );
  }
}
