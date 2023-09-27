import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/modules/noticias/noticias_model.dart';
import 'package:http/http.dart';
import 'package:webfeed_revised/webfeed_revised.dart';

class NoticiasController {
  static final NoticiasController _instance = NoticiasController._();

  NoticiasController._();

  factory NoticiasController() => _instance;

  final AppStream<List<Noticia>> newsStream = AppStream<List<Noticia>>();

  Future<void> init() async {
    try {
      final response = await get(Uri.parse(
          'https://news.google.com/rss/search?q=aux%C3%ADlio%20brasil&hl=pt-BR&gl=BR&ceid=BR%3Apt-419'));
      var rssFeed = RssFeed.parse(response.body);
      List<Noticia> news = [];
      for (var item in rssFeed.items!) {
        String desc = item.description!;
        Noticia newItem = Noticia(
          title: item.title!,
          url: item.link!,
          subtitle: desc,
          date: item.pubDate,
        );
        news.add(newItem);
        newsStream.add(news);
      }
    } catch (e) {
      newsStream.add([]);
    }
  }
}
