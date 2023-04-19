import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rxdart/rxdart.dart';

class AdBannerStorage {
  final BehaviorSubject<BannerAd?> stream = BehaviorSubject<BannerAd?>.seeded(null);
  final String type;

  AdBannerStorage(this.type);

  static List<AdBannerStorage> values = [];

  static BehaviorSubject<BannerAd?> get(String type) {
    final streamsByType = values.where((e) => e.type == type).toList();
    if (streamsByType.isEmpty) {
      values.add(AdBannerStorage(type));
      return values.last.stream;
    } else {
      return streamsByType.last.stream;
    }
  }

  static List<BehaviorSubject<BannerAd?>> getList(List<String>? behavior) =>
      behavior!.map((e) => AdBannerStorage.get(e)).toList();
}
