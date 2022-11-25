import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  String category = 'T-shirt';

  changeCategory(String value) {
    category = value;
  }
}
