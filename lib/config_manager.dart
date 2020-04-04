import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static void setString(ConfigKeys key, String value) {
    _setValue(key, value);
  }

  static void setInt(ConfigKeys key, int value) {
    _setValue(key, value);
  }

  static void _setValue(ConfigKeys key, Object value) async {
    String keyStr;
    if (value is String) {
      keyStr = _getKeyString(key);
    } else if (value is int) {
      keyStr = _getKeyInt(key);
    }

    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (value is String) {
      pref.setString(keyStr, value);
    } else if (value is int) {
      pref.setInt(keyStr, value);
    }
  }

  // TODO: move common operations to _getValue
  static Future<String> getString(ConfigKeys key) async {
    String keyStr;
    keyStr = _getKeyString(key);

    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (!pref.containsKey(keyStr)) {
      switch (key) {
        case ConfigKeys.ip:
          pref.setString(keyStr, "10.0.0.33");
          break;
        default:
      }
    }
    return pref.getString(keyStr);
  }

  static Future<int> getInt(ConfigKeys key) async {
    String keyStr;
    keyStr = _getKeyInt(key);

    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (!pref.containsKey(keyStr)) {
      switch (key) {
        case ConfigKeys.port:
          pref.setInt(keyStr, 5001);
          break;
        default:
      }
    }
    return pref.getInt(keyStr);
  }

  static String _getKeyString(ConfigKeys key) {
    switch (key) {
      case ConfigKeys.ip:
        return "ip";
        break;
      default:
        throw Exception("Invalid data type for key ${key.toString()}");
    }
  }

  static String _getKeyInt(ConfigKeys key) {
    switch (key) {
      case ConfigKeys.port:
        return "port";
        break;
      default:
        throw Exception("Invalid data type for key ${key.toString()}");
    }
  }
}

enum ConfigKeys {
  ip,
  port,
}