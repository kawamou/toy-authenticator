import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesClient = Provider((ref) => SharedPreferencesClient());

// SharedPreferencesClient はアプリの永続化の仕組みであるSharedPreferencesのクライアントです
// https://zenn.dev/dd_sho/articles/222cd0cdf75c4b
// key-value形式で記述されたxmlファイルとしてアプリ内に保存される
class SharedPreferencesClient {
  // List<Map>の構造の例は下記のような感じ
  // List<Map<String, dynamic>> users = [
  //   { "name": 'John', "age": 18 },
  //   { "name": 'Jane', "age": 21 },
  //   { "name": 'Mary', "age": 23 },
  // ];
  Future<List<Map<String, dynamic>>> getJsonList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return List<Map<String, dynamic>>.from(
        jsonDecode(prefs.getString(key) ?? '[]'));
  }

  Future<void> saveJson(String key, List<Map<String, dynamic>> json) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(json));
  }
}
