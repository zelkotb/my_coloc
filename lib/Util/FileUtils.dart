import 'dart:convert';

import 'package:flutter/services.dart';

class FileUtils {

  static Future<String>_loadFromAsset(String name) async {
    return await rootBundle.loadString("files/"+name+".json");
  }

  static Future parseJson(String name) async {
    String jsonString = await _loadFromAsset(name);
    return jsonDecode(jsonString);
  }
}