import 'package:flutter/material.dart';
import 'package:v_story_viewer/v_story_viewer.dart';

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
  late final List<VStoryGroup> _storyGroups;

  // Header data shown فوق الـ viewer (يثبت ولا يختفي عند الضغط)
  late VStoryUser _headerUser;
  DateTime? _headerStoryCreatedAt;
  int _currentGroupIndex = 0;

  @override
  void initState() {
    super.initState();
    _storyGroups = _mapLeaguesToStoryGroups(widget.leagues);
    _currentGroupIndex = widget.startIndex.clamp(0, _storyGroups.length - 1);
    _headerUser = _storyGroups[_currentGroupIndex].user;
    // مبدئيًا خذ وقت أول ستوري للمجموعة المختارة
    _headerStoryCreatedAt = _storyGroups[_currentGroupIndex].sortedStories.first.createdAt;
  }

  void _syncHeaderIfChanged({required VStoryGroup group, required VStoryItem item}) {
    final newIndex = _storyGroups.indexWhere((g) => g.user.id == group.user.id);
    if (!mounted) return;

    final nextUser = group.user;
    final nextCreatedAt = item.createdAt;

    if (newIndex == -1) {
      // ما نتوقع يصير، لكن نحافظ على تحديث الوقت لو تغيّر
      if (_headerStoryCreatedAt != nextCreatedAt) {
        setState(() => _headerStoryCreatedAt = nextCreatedAt);
      }
      return;
    }

    final shouldUpdateUser = newIndex != _currentGroupIndex;
    final shouldUpdateTime = _headerStoryCreatedAt != nextCreatedAt;

    if (!shouldUpdateUser && !shouldUpdateTime) return;

    setState(() {
      if (shouldUpdateUser) {
        _currentGroupIndex = newIndex;
        _headerUser = nextUser;
      }
      if (shouldUpdateTime) {
        _headerStoryCreatedAt = nextCreatedAt;
      }
    });
  }

  String _formatRelativeTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) return 'الآن';
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
    if (diff.inDays < 7) return 'منذ ${diff.inDays} يوم';

    final weeks = (diff.inDays / 7).floor();
    if (weeks < 4) return 'منذ $weeks أسبوع';

    final months = (diff.inDays / 30).floor();
    if (months < 12) return 'منذ $months شهر';

    final years = (diff.inDays / 365).floor();
    return 'منذ $years سنة';
  }

  Widget _overlayHeader(BuildContext context) {
    final imageUrl = _headerUser.imageUrl.trim();
    final timeText = _formatRelativeTime(_headerStoryCreatedAt);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 20),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            ClipOval(
              child: SizedBox(
                width: 36,
                height: 36,
                child: imageUrl.isEmpty
                    ? Container(
                        color: Colors.grey.shade700,
                        child: const Icon(Icons.person,
                            color: Colors.white, size: 20),
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        // بدون أي Loader أثناء التحميل
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox.expand();
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade700,
                            child: const Icon(Icons.person,
                                color: Colors.white, size: 20),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _headerUser.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (timeText.isNotEmpty)
                    Text(
                      timeText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
    );
  }

  DateTime _parsePublishedAt(String? value) {
    if (value == null || value.trim().isEmpty) {
      return DateTime.now();
    }

    final parsed = DateTime.tryParse(value);
    return parsed?.toLocal() ?? DateTime.now();
  }

  List<VStoryGroup> _mapLeaguesToStoryGroups(
      List<LeagueHighlightsModel> leagues,
      ) {
    return leagues.asMap().entries.map((entry) {
      final leagueIndex = entry.key;
      final league = entry.value;

      final stories = <VStoryItem>[];

      for (final highlight in league.highlights) {
        final title = highlight.title.trim();
        final createdAt = _parsePublishedAt(highlight.publishedAt);

        for (final media in highlight.media) {
          final url = media.url.trim();
          if (url.isEmpty) continue;

          if (media.type.toLowerCase() == 'video') {
            stories.add(
              VVideoStory(
                url: url,
                caption: title.isEmpty ? null : title,
                createdAt: createdAt,
                isSeen: false,
              ),
            );
          } else {
            stories.add(
              VImageStory(
                url: url,
                caption: title.isEmpty ? null : title,
                createdAt: createdAt,
                isSeen: false,
                duration: const Duration(seconds: 5),
              ),
            );
          }
        }
      }

      if (stories.isEmpty) {
        stories.add(
          VTextStory(
            text: 'لا توجد وسائط',
            backgroundColor: Colors.black,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
            createdAt: DateTime.now(),
            isSeen: false,
          ),
        );
      }

      return VStoryGroup(
        user: VStoryUser(
          id: 'league_$leagueIndex',
          name: league.name,
          imageUrl: (league.logoUrl != null && league.logoUrl!.isNotEmpty)
              ? league.logoUrl!
              : '',
        ),
        stories: stories,
      );
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          VStoryViewer(
            key: ValueKey(
                'story_viewer_${widget.startIndex}_${widget.leagues.length}'),
            storyGroups: _storyGroups,
            initialGroupIndex: widget.startIndex,
            onProgress: (group, item, progress) {
              _syncHeaderIfChanged(group: group, item: item);
            },
            onLoad: (group, item) {
              _syncHeaderIfChanged(group: group, item: item);
            },
            config: VStoryConfig(
              defaultDuration: const Duration(seconds: 5),
              progressColor: Colors.white,
              progressBackgroundColor: Colors.white24,
              enableCaching: true,
              enablePreloading: true,
              showReplyField: false,
              // نلغي هيدر الباكيج لأنه يختفي عند لمس الشاشة
              showHeader: false,
              maxCacheSize: 300 * 1024 * 1024,
              maxCacheAge: const Duration(days: 7),
              maxCacheObjects: 80,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _overlayHeader(context),
          ),
        ],
      ),
    );
  }
}
