import 'package:five_stars/utils/utils.dart';

class AppData {
  static String _username;
  static String _uid;

  static void set username(String username) {
    _username = username;
    SharedPreferencesManager.instance.setString('username', username);
  }
  static void set uid(String uid) {
    _uid = uid;
    SharedPreferencesManager.instance.setString('uid', uid);
  }

  static String get username {
    if(_username == null) {
      _username = SharedPreferencesManager.instance.getString('username');
    }
    return _username;
  }
  
  static String get uid {
    if(_uid == null) {
      _uid = SharedPreferencesManager.instance.getString('username');
    }
    return _uid;
  }
}