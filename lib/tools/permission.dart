import 'package:permission_handler/permission_handler.dart';

//默认权限
List<String> defaultList = ['camera', 'location'];

class KPermission {
  static check() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    // //存储权限
    // if (await Permission.storage.isUndetermined) {
    // }
    // //定位权限获取
    // if (await Permission.location.isUndetermined) {
    // }
    // //相机权限获取
    // if (await Permission.camera.isUndetermined) {
    // }
  }
}
