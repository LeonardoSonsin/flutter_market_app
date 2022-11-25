import 'package:flutter/material.dart';
import 'package:flutter_market_app/controllers/cart_controller.dart';
import 'package:flutter_market_app/controllers/favorite_controller.dart';
import 'package:flutter_market_app/controllers/product_controller.dart';
import 'package:flutter_market_app/screens/product/product_screen.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String uuid;
  final String image;
  final String title;
  final String description;
  final String price;
  final bool favorite;
  final String category;

  ProductCard(
      {Key? key,
      required this.id,
      required this.uuid,
      required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.favorite,
      required this.category})
      : super(key: key);

  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());
  final favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      child: Ink(
        decoration: BoxDecoration(
            boxShadow: kElevationToShadow[3],
            borderRadius: BorderRadius.circular(15.0),
            color: Theme.of(context).cardColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productImage(),
            productCategory(),
            productTitle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                productPrice(),
                buildContainerAdd(),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        productController.buildProductController(
            id: id,
            uuid: uuid,
            image: image,
            title: title,
            description: description,
            price: price,
            productController: productController,
            favorite: favorite);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => ProductScreen(
              productController: productController,
              cartController: cartController,
              favoriteController: favoriteController,
              category: category,
            ),
          ),
        );
      },
    );
  }

  Padding productPrice() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child:
          Text('\$$price', style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Padding productCategory() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
      child: Text(
        category,
        style: const TextStyle(fontSize: 14.0, color: Colors.deepOrange),
      ),
    );
  }

  Container buildContainerAdd() {
    return Container(
      width: 37.5,
      height: 37.5,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
        color: Colors.black87,
      ),
      child: const Icon(Icons.add_sharp, color: Colors.white),
    );
  }

  Padding productTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(title,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
    );
  }

  Widget productImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      child: Image.network(
        image,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/image-error.png');
        },
      ),
    );
  }
}
