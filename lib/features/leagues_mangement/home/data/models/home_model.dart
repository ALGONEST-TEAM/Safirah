import 'banners_model.dart';
import 'league_highlights_model.dart';
import 'news_item_model.dart';
import 'upcoming_match_model.dart';

class HomeModel {
  final List<BannerModel> banners;
  final List<LeagueHighlightsModel> highlightsByLeague;
  final List<UpcomingMatchModel> upcomingMatches;
  final List<NewsItemModel> news;

  HomeModel({
    required this.banners,
    required this.highlightsByLeague,
    required this.upcomingMatches,
    required this.news,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      banners: BannerModel.fromJsonList((json['banners'] ?? []) as List),
      highlightsByLeague: LeagueHighlightsModel.fromJsonList(
          (json['highlights_by_league'] ?? []) as List),
      upcomingMatches:
      UpcomingMatchModel.fromJsonList((json['upcoming_matches'] ?? []) as List),
      news: NewsItemModel.fromJsonList((json['news'] ?? []) as List),
    );
  }

  static HomeModel empty() {
    return HomeModel(
      banners: [],
      highlightsByLeague: [],
      upcomingMatches: [],
      news: [],
    );
  }
}