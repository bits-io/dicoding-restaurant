import 'dart:convert';
import 'package:flutter/services.dart';

class JsonLoader {
  Future<Map<String, dynamic>> loadJson(String path) async {
    final jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }
}