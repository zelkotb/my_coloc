import 'package:shared_preferences/shared_preferences.dart';

class UtilStorage {

  static Future<void> setToSharedPreferences(String key, String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key,value);
  }

  static Future<String> getFromSharedPreferences(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}