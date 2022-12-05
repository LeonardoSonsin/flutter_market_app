import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  String id = '';
  String uuid = '';
  String image = '';
  String title = '';
  String description = '';
  String price = '';
  String category = '';
  bool favorite = false;
  int quantity = 1;

  buildProductController(
      {required String id,
      required String uuid,
      required String image,
      required String title,
      required String description,
      required String price,
      required String category,
      required bool favorite,
      required int quantity,
      required ProductController productController}) {
    productController.id = id;
    productController.uuid = uuid;
    productController.image = image;
    productController.title = title;
    productController.description = description;
    productController.price = price;
    productController.category = category;
    productController.favorite = favorite;
    productController.quantity = quantity;
  }
}
