import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  String id = '';
  String uuid = '';
  String image = '';
  String title = '';
  String description = '';
  String price = '';
  bool favorite = false;

  buildProductController(
      {required String id,
      required String uuid,
      required String image,
      required String title,
      required String description,
      required String price,
      required bool favorite,
      required ProductController productController}) {
    productController.id = id;
    productController.uuid = uuid;
    productController.image = image;
    productController.title = title;
    productController.description = description;
    productController.price = price;
    productController.favorite = favorite;
  }
}
