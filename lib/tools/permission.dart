import 'package:permission_handler/permission_handler.dart';

//默认权限
List<String> defaultList = ['camera', 'location'];

class KPermission {
  static requestPermission() async {
    [
      Permission.storage,
      Permission.location,
      Permission.camera,
    ].request();
  }
}
