import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../leagues/persntaion/page/details_league_user_page.dart';
import '../../data/models/banners_model.dart';

enum BannerTapActionType { none, league, external }

class BannerTapAction {
  const BannerTapAction._({
    required this.type,
    this.leagueSyncId,
    this.externalUri,
  });

  const BannerTapAction.none() : this._(type: BannerTapActionType.none);

  const BannerTapAction.league(String leagueSyncId)
      : this._(
          type: BannerTapActionType.league,
          leagueSyncId: leagueSyncId,
        );

  const BannerTapAction.external(Uri externalUri)
      : this._(
          type: BannerTapActionType.external,
          externalUri: externalUri,
        );

  final BannerTapActionType type;
  final String? leagueSyncId;
  final Uri? externalUri;
}

Uri? parseExternalBannerUri(String rawUrl) {
  final normalized = rawUrl.trim();
  if (normalized.isEmpty) return null;

  Uri? uri = Uri.tryParse(normalized);
  if (uri == null || !uri.hasScheme) {
    uri = Uri.tryParse('https://$normalized');
  }

  if (uri == null) return null;
  if (uri.scheme != 'http' && uri.scheme != 'https') return null;
  if (uri.host.trim().isEmpty) return null;

  return uri;
}

BannerTapAction resolveBannerTapAction(BannerModel banner) {
  final type = banner.type.trim().toLowerCase();

  if (type == 'league') {
    final leagueSyncId = banner.bannerable.syncId.trim();
    if (leagueSyncId.isNotEmpty) {
      return BannerTapAction.league(leagueSyncId);
    }
  }

  if (type == 'external') {
    final uri = parseExternalBannerUri(banner.linkUrl);
    if (uri != null) {
      return BannerTapAction.external(uri);
    }
  }

  return const BannerTapAction.none();
}

class BannersWidget extends StatelessWidget {
  final List<BannerModel> banners;
  final String? currentLeagueSyncId;

  const BannersWidget({
    super.key,
    required this.banners,
    this.currentLeagueSyncId,
  });

  Future<void> _handleBannerTap(BuildContext context, BannerModel banner) async {
    final action = resolveBannerTapAction(banner);

    switch (action.type) {
      case BannerTapActionType.league:
        final targetLeagueSyncId = action.leagueSyncId!;
        if (currentLeagueSyncId?.trim() == targetLeagueSyncId) return;

        navigateTo(
          context,
          DetailsLeagueUserPage(leagueSyncId: targetLeagueSyncId),
        );
        return;
      case BannerTapActionType.external:
        final launched = await launchUrl(
          action.externalUri!,
          mode: LaunchMode.externalApplication,
        );
        if (!launched && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تعذر فتح الرابط الخارجي')),
          );
        }
        return;
      case BannerTapActionType.none:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 126.h,
        autoPlay: banners.length > 1,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
        reverse: false,
        enableInfiniteScroll: banners.length > 1,
        viewportFraction: 0.93,
        enlargeCenterPage: false,
        padEnds: true,
      ),
      items: banners.map((items) {
        return GestureDetector(
          onTap: () => _handleBannerTap(context, items),
          child: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: OnlineImagesWidget(
                  imageUrl: items.imageUrl,
                  fit: BoxFit.cover,
                  size: Size(double.infinity, 126.h),
                  borderRadius: 8.r,
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
