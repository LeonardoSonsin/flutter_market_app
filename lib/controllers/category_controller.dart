import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  String category = '';

  changeCategory(String value) {
    category = value;
  }
}
