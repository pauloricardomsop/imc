import 'package:benefits_brazil/app/core/models/app_stream.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/bf/news/bf_news_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:webfeed_plus/domain/rss_feed.dart';

class BfNewsController {
  static final BfNewsController _instance = BfNewsController._();

  BfNewsController._();

  factory BfNewsController() => _instance;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  final AppStream<List<News>> newsStream = AppStream<List<News>>();

  Future<void> init() async {
    try {
      final response = await get(Uri.parse(
          'https://news.google.com/rss/search?q=bolsa%20familia&hl=pt-BR&gl=BR&ceid=BR%3Apt-419'));
      var rssFeed = RssFeed.parse(response.body);
      List<News> news = [];
      for (var item in rssFeed.items!) {
        String? desc = parse(item.description).text;
        News newItem = News(
          title: item.title!,
          url: item.link!,
          subtitle: desc ?? empty,
          date: item.pubDate,
        );
        news.add(newItem);
      }
      newsStream.add(news);
    } catch (e) {
      newsStream.add(<News>[]);
    }
  }
}
