import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../data/models/league_highlights_model.dart';
import '../pages/leagues_stories_page.dart';
import 'stories_card_widget.dart';

class StoriesListWidget extends StatelessWidget {
  final List<LeagueHighlightsModel> stories;

  const StoriesListWidget({super.key, required this.stories});

  MediaItemModel? getLeagueCover(LeagueHighlightsModel league) {
    for (final h in league.highlights) {
      if (h.media.isNotEmpty) return h.media.first;
    }
    return null;
  }

  bool leagueHasVideoCover(LeagueHighlightsModel league) {
    final cover = getLeagueCover(league);
    return cover?.type == 'video';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (_, __) =>  SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final league = stories[index];
          final cover = getLeagueCover(league);
          final isVideo = cover?.type == 'video';

          return StoriesCardWidget(
            imageUrl: isVideo ? '' : (cover?.url ?? ''),
            videoUrl: isVideo ? cover?.url : null,
            isVideo: isVideo,
            onTap: () {
             navigateTo(context, LeaguesStoriesViewer(
               leagues: stories,
               startIndex: index,   // يبدأ من اللي ضغطت عليه
             ),);
            },
          );
        },
      ),
    );
  }
}


// class _StoriesCard extends StatelessWidget {
//   final String imageUrl;
//   final bool isVideo;
//   final VoidCallback onTap;
//
//   const _StoriesCard({
//     required this.imageUrl,
//     required this.isVideo,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AspectRatio(
//         aspectRatio: 10 / 16,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(18),
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               OnlineImagesWidget(
//                 imageUrl: imageUrl,
//                 fit: BoxFit.cover,
//                 borderRadius: 8.r,
//               ),
//               Positioned.fill(
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                       colors: [
//                         Colors.black.withValues(alpha: 0.35),
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               if (isVideo)
//                 Center(
//                   child: Container(
//                     width: 54,
//                     height: 54,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.withValues(alpha: 0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.play_arrow_rounded,
//                       size: 34,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
