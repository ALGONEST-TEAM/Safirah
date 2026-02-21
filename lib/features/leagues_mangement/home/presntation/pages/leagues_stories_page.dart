import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import 'package:story_view/story_view.dart';

import '../../data/models/league_highlights_model.dart';

class LeaguesStoriesViewer extends StatefulWidget {
  final List<LeagueHighlightsModel> leagues;
  final int startIndex;

  const LeaguesStoriesViewer({
    super.key,
    required this.leagues,
    required this.startIndex,
  });

  @override
  State<LeaguesStoriesViewer> createState() => _LeaguesStoriesViewerState();
}

class _LeaguesStoriesViewerState extends State<LeaguesStoriesViewer> {
  final StoryController _controller = StoryController();
  late int _leagueIndex;
  late List<StoryItem> _items;

  LeagueHighlightsModel get _league => widget.leagues[_leagueIndex];

  @override
  void initState() {
    super.initState();
    _leagueIndex = widget.startIndex;
    _items = _buildItemsForLeague(_league);
  }

  List<StoryItem> _buildItemsForLeague(LeagueHighlightsModel league) {
    final items = <StoryItem>[];

    for (final h in league.highlights) {
      for (final m in h.media) {
        if (m.type == 'video') {
          items.add(
            StoryItem.pageVideo(
              m.url,
              controller: _controller,
              caption: Text(
                h.title,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          items.add(
            StoryItem.pageImage(
              url: m.url,
              controller: _controller,
              caption: Text(
                h.title,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      }
    }

    if (items.isEmpty) {
      items.add(
        StoryItem.text(
          title: 'لا توجد وسائط',
          backgroundColor: Colors.black,
        ),
      );
    }

    return items;
  }

  void _goNextLeagueOrClose() {
    if (_leagueIndex < widget.leagues.length - 1) {
      setState(() {
        _leagueIndex++;
        _items = _buildItemsForLeague(_league);
      });
      _controller.play();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Localizations
        .localeOf(context)
        .languageCode;
    final isRtl = ['ar', 'en'].contains(lang);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              StoryView(
                storyItems: _items,
                controller: _controller,
                repeat: false,
                progressPosition: ProgressPosition.top,
                indicatorHeight: IndicatorHeight.medium,
                onComplete: _goNextLeagueOrClose,
                onVerticalSwipeComplete: (direction) {
                  if (direction == Direction.down) Navigator.pop(context);
                },
              ),
              Directionality(
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                child: Positioned(
                  top: 18.h,
                  left: 12,
                  right: 12,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white12,
                        backgroundImage: _league.logoUrl == null
                            ? null
                            : NetworkImage(_league.logoUrl!),
                        child: _league.logoUrl == null
                            ? const Icon(Icons.sports_soccer,
                            color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AutoSizeTextWidget(
                          text: _league.name,
                          fontSize: 13.4.sp,
                          maxLines: 2,
                          colorText: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
