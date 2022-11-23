import 'package:get/get.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  List<Map<String, dynamic>> favorites = [];
}
