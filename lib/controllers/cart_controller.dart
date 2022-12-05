import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  List<Map<String, dynamic>> cart = [];
  double total = 0.0;

  addCartPrice({required String price, required int quantity}) {
    total += double.parse(price) * quantity;
  }

  removeCartPrice({required String price}) {
    total -= double.parse(price);
  }

  resetCartPrice() {
    total = 0;
  }

  cartSize() {
    return cart.length;
  }
}
