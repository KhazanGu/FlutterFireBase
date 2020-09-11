import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class KZSharedPreferences {
  
  KZSharedPreferences._privateConstructor();

  static final KZSharedPreferences _instance = KZSharedPreferences._privateConstructor();

  static KZSharedPreferences get instance => _instance;


  Future<Map<String, dynamic>> jsonRead(String key) async {

    final prefs = await SharedPreferences.getInstance();

    return json.decode(prefs.getString(key));

  }

  Future<bool> jsonSave(String key, value) async {

    try {
      
      final prefs = await SharedPreferences.getInstance();

      final bool status = await prefs.setString(key, json.encode(value));

      return status;

    } catch (e) {

      return false;

    }    

  }

  Future<bool> remove(String key) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.remove(key);

  }

}



