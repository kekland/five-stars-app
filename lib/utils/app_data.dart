import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/utils/utils.dart';

class AppData {
  static String _username;
  static User userData;
  static String _token;

  static set username(String username) {
    _username = username;
    SharedPreferencesManager.instance.setString('username', username);
  }

  static String get username {
    if(_username == null) {
      _username = SharedPreferencesManager.instance.getString('username');
    }
    return _username;
  }
  
  static set token(String token) {
    _token = token;
    SharedPreferencesManager.instance.setString('token', token);
  }

  static String get token {
    if(_token == null) {
      _token = SharedPreferencesManager.instance.getString('username');
    }
    return _token;
  }
}