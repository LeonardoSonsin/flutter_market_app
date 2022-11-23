import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  List<Map<String, dynamic>> cart = [];
  double total = 0.0;

  addCartPrice({required double price}) {
    total += price;
  }
  removeCartPrice({required double price}) {
    total -= price;
  }
  resetCartPrice() {
    total = 0;
  }
}
