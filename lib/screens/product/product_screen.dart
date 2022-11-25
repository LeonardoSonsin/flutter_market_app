import 'package:flutter/material.dart';
import 'package:flutter_market_app/controllers/cart_controller.dart';
import 'package:flutter_market_app/controllers/favorite_controller.dart';
import 'package:flutter_market_app/controllers/product_controller.dart';
import 'package:flutter_market_app/data/favorite_service.dart';
import 'package:flutter_market_app/data/product_service.dart';
import 'package:flutter_market_app/models/product.dart';

class ProductScreen extends StatefulWidget {
  final ProductController productController;
  final CartController cartController;
  final FavoriteController favoriteController;
  final String category;

  const ProductScreen(
      {Key? key,
      required this.productController,
      required this.cartController,
      required this.favoriteController,
      required this.category})
      : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductService productService = ProductService();
  FavoriteService favoriteService = FavoriteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detail Product'),
        actions: [
          IconButton(
            icon: widget.productController.favorite
                ? const Icon(Icons.favorite_outlined)
                : const Icon(Icons.favorite_border_outlined),
            onPressed: () {
              if (widget.productController.favorite) {
                productService.updateFavorite(
                    category: widget.category,
                    productId: widget.productController.id,
                    favorite: false);

                favoriteService.removeFavorite(
                    productUuid: widget.productController.uuid);
              } else {
                productService.updateFavorite(
                    category: widget.category,
                    productId: widget.productController.id,
                    favorite: true);

                favoriteService.addFavorite(
                    uuid: widget.productController.uuid,
                    image: widget.productController.image,
                    title: widget.productController.title,
                    description: widget.productController.description,
                    price: widget.productController.price);
              }

              widget.productController.favorite =
                  !widget.productController.favorite;
              setState(() {});
            },
          )
        ],
      ),
      body: Column(
        children: [
          Text(widget.productController.uuid),
          SizedBox(
              height: MediaQuery.of(context).size.height / 2.3,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.productController.image)),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.productController.title,
                        style: const TextStyle(fontSize: 24.0)),
                    Container(
                      width: 100.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.indigoAccent),
                      alignment: Alignment.center,
                      child: Text(
                        '\$${widget.productController.price}',
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    widget.productController.description,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.remove)),
                    const Text('0'),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                    InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        widget.cartController.cart.add(Product(
                                image: widget.productController.image,
                                title: widget.productController.title,
                                description:
                                    widget.productController.description,
                                price: widget.productController.price,
                                favorite: widget.productController.favorite)
                            .toJson());
                        widget.cartController.addCartPrice(
                            price: widget.productController.price);
                        Navigator.of(context).pop();
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black),
                        height: 60,
                        width: 200,
                        child: const Center(
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
