import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static const _USERNAME = 'USERNAME';
  static const _COOKIE = 'COOKIE';


  //AUTH VALID
  static Future<String?> getCookie() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_COOKIE);
  }
  static Future<void> setCookie(String cookie) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_COOKIE, cookie);
  }

  static Future<void> removeCookie() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_COOKIE);
  }

  //UI
  static Future<void> setUsername(String username) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_USERNAME, username);
  }

  static Future<String?> getUsername() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_USERNAME);
  }

}
