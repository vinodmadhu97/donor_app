import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
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
