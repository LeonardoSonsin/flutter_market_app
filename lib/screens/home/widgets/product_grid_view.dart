import 'package:flutter/material.dart';
import 'package:flutter_market_app/data/product_service.dart';
import 'package:flutter_market_app/models/product.dart';
import 'package:flutter_market_app/screens/home/widgets/product_card.dart';

class ProductGridView extends StatefulWidget {
  final String category;

  const ProductGridView({Key? key, required this.category}) : super(key: key);

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: productService.getProducts(widget.category),
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
      category: widget.category);
}
