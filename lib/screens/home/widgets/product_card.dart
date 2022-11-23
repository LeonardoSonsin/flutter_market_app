import 'package:flutter/material.dart';
import 'package:flutter_market_app/controllers/cart_controller.dart';
import 'package:flutter_market_app/controllers/favorite_controller.dart';
import 'package:flutter_market_app/controllers/product_controller.dart';
import 'package:flutter_market_app/screens/product/product_screen.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double price;
  final bool favorite;

  ProductCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.favorite})
      : super(key: key);

  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());
  final favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        child: Ink(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              boxShadow: kElevationToShadow[3],
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).cardColor),
          child: SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.network(image),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                ),
                Text('\$$price',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
        onTap: () {
          productController.buildProductController(
              image: image,
              title: title,
              description: description,
              price: price,
              productController: productController,
              favorite: productController.favorite);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (builder) => ProductScreen(
                productController: productController,
                cartController: cartController,
                favoriteController: favoriteController,
              ),
            ),
          );
        },
      ),
    );
  }
}
