import 'package:flutter/material.dart';
import 'package:flutter_market_app/controllers/favorite_controller.dart';
import 'package:flutter_market_app/data/favorite_service.dart';
import 'package:flutter_market_app/models/product.dart';
import 'package:get/get.dart';

import '../home/widgets/product_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    FavoriteService favoriteService = FavoriteService();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: StreamBuilder<List<Product>>(
        stream: favoriteService.getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;
            return GridView.count(
                childAspectRatio: 0.815,
                mainAxisSpacing: 16.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                children: products.map(buildProductCard).toList());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      /*Column(
        children: [
          SizedBox(
            height: 500,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  Product product = Product(
                      image: favorites[index]['image'],
                      title: favorites[index]['title'],
                      description: favorites[index]['description'],
                      price: favorites[index]['price'],
                      favorite: favorites[index]['favorite']);
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 150,
                    child: Row(
                      children: [
                        Image.network(product.image),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                '\$${product.price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: favoriteController.favorites.length),
          ),
        ],
      ),*/
    );
  }

  Widget buildProductCard(Product product) => ProductCard(
      id: product.id,
      uuid: product.uuid,
      image: product.image,
      title: product.title,
      description: product.description,
      price: product.price,
      favorite: product.favorite,
      category: 'Category');
}
