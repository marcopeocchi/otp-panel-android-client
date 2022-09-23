import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_listener/models/config_model.dart';

class ConfigRepository {
  Future<ConfigModel> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final apiUrl = prefs.getString("api_url");

    if (apiUrl != null && apiUrl.isNotEmpty) {
      return ConfigModel.fromJSON(jsonDecode(apiUrl));
    }

    return ConfigModel(url: "");
  }

  Future<ConfigModel> saveSettings(ConfigModel config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("api_url", jsonEncode(config.toJson()));
    await prefs.setString("api_url_plain", config.url);
    return config;
  }
}
