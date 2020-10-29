import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';

class SpUtil {
  static SharedPreferences preferences;
  static PackageInfo packageInfo;
  static Future<bool> initInstance() async {
    preferences = await SharedPreferences.getInstance();
    packageInfo = await PackageInfo.fromPlatform();
    return true;
  }
}
