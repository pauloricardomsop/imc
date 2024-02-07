import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:svr/app/modules/user/user_model.dart';

class UserRepository {
  static late SharedPreferences shared;

  static Future<void> init() async {
    shared = await SharedPreferences.getInstance();
  }

  static List<UserModel> getUsers() {
    String? value = shared.getString('users');
    if (value == null) {
      value = '[]';
      shared.setString('users', value);
    }
    return jsonDecode(shared.getString('users') ?? '[]').map<UserModel>((e) => UserModel.fromMap(e)).toList();
  }

  static Future<void> addUser(UserModel user) async {
    final users = getUsers();
    users.add(user);
    shared.setString('users', jsonEncode(users.map((e) => e.toMap()).toList()));
  }
}
