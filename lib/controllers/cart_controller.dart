import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  List<Map<String, dynamic>> cart = [];
  double total = 0.0;

  addCartPrice({required String price}) {
    total += double.parse(price);
  }
  removeCartPrice({required String price}) {
    total -= double.parse(price);
  }
  resetCartPrice() {
    total = 0;
  }
}
