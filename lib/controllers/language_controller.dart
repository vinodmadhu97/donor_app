import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final _box = GetStorage();
  final _lngBox = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  void changeLanguage(String param1, String param2) {
    var locale = Locale(param1, param2);
    Get.updateLocale(locale);
  }

  void setLocale(String param1, String param2) {
    _lngBox.write("param1", param1);
    _lngBox.write("param2", param2);
    print("-----------------------> set locale");
  }

  Locale? getLocale() {
    var param1 = _lngBox.read('param1');
    var param2 = _lngBox.read('param2');
    if (param1 == null) {
      return null;
    } else {
      return Locale(param1, param2);
    }
  }

  void setLanguage(String lang) {
    _box.write("lng", lang);
    print("set $lang");
  }

  String getLanguage() {
    var lng = _box.read('lng');
    print("get $lng");
    return lng;
  }
}
