import 'package:svr/app/core/models/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements Service {
  static late SharedPreferences _instace;

  @override
  Future<void> initialize() async {
    _instace = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await _instace.setString(key, value);
  }

  static String? getString(String key) {
    return _instace.getString(key);
  }
}
