import 'package:shared_preferences/shared_preferences.dart';

class SplashRepository {
  static const _key = 'tip';

  static Future<int> getTip() async {
    final instance = await SharedPreferences.getInstance();
    final int? tip = instance.getInt(_key);
    if (tip == null) {
      await setTip(0);
    }
    return instance.getInt(_key) ?? 0;
  }

  static Future<void> setTip(int tip) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setInt(_key, tip);
  }
}
