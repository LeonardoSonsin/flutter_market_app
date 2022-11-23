import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  String image = '';
  String title = '';
  String description = '';
  double price = 0.0;
  bool favorite = false;

  buildProductController(
      {required String image,
      required String title,
      required String description,
      required double price,
      required bool favorite,
      required ProductController productController}) {
    productController.image = image;
    productController.title = title;
    productController.description = description;
    productController.price = price;
    productController.favorite = favorite;
  }
}
