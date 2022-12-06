import 'package:flutter/material.dart';
import 'package:flutter_market_app/controllers/cart_controller.dart';
import 'package:flutter_market_app/controllers/product_controller.dart';
import 'package:flutter_market_app/data/product_service.dart';
import 'package:flutter_market_app/models/product.dart';
import 'package:flutter_market_app/themes/theme_colors.dart';

class ProductScreen extends StatefulWidget {
  final ProductController productController;
  final CartController cartController;
  final String category;

  const ProductScreen(
      {Key? key,
      required this.productController,
      required this.cartController,
      required this.category})
      : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();
    widget.productController.quantity = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        productImage(context),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  productTitle(context),
                  productFavoriteIcon(),
                ],
              ),
              productDescription(context),
              productCategory(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Divider(height: 1, color: ThemeColors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttonProductQuantity(context),
                  buttonAddProduct(context),
                ],
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        )
      ],
    );
  }

  SizedBox productImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.2,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          child:
              Image.network(widget.productController.image, fit: BoxFit.cover)),
    );
  }

  Text productTitle(BuildContext context) {
    return Text(
      widget.productController.title,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  IconButton productFavoriteIcon() {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      iconSize: 35.0,
      icon: widget.productController.favorite
          ? const Icon(Icons.favorite, color: ThemeColors.greenColor)
          : const Icon(Icons.favorite_outline),
      onPressed: () {
        if (widget.productController.favorite) {
          productService.updateFavorite(
              category: widget.category,
              uuid: widget.productController.uuid,
              favorite: false);

          if (widget.category == 'Favorites') {
            productService
                .getProductCategory(productId: widget.productController.id)
                .then((value) {
              productService.updateFavorite(
                  category: value,
                  uuid: widget.productController.uuid,
                  favorite: false);
            });
          }
          productService.removeFavorite(uuid: widget.productController.uuid);
        } else {
          productService.updateFavorite(
              category: widget.category,
              uuid: widget.productController.uuid,
              favorite: true);
          productService.addFavorite(
              id: widget.productController.id,
              uuid: widget.productController.uuid,
              category: widget.productController.category,
              image: widget.productController.image,
              title: widget.productController.title,
              description: widget.productController.description,
              price: widget.productController.price);
        }

        widget.productController.favorite = !widget.productController.favorite;
        setState(() {});
      },
    );
  }

  Padding productDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        widget.productController.description,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Text productCategory() {
    return Text(
      widget.productController.category,
      style: const TextStyle(fontSize: 16.0, color: ThemeColors.greenColor),
    );
  }

  Container buttonProductQuantity(BuildContext context) {
    return Container(
      height: 50,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: ThemeColors.lightGrey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                widget.productController.quantity > 1
                    ? setState(() {
                        widget.productController.quantity--;
                      })
                    : null;
              },
              icon: const Icon(Icons.remove)),
          Text('${widget.productController.quantity}',
              style: Theme.of(context).textTheme.bodyMedium),
          IconButton(
              onPressed: () {
                widget.productController.quantity < 10
                    ? setState(() {
                        widget.productController.quantity++;
                      })
                    : null;
              },
              icon: const Icon(Icons.add)),
        ],
      ),
    );
  }

  InkWell buttonAddProduct(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: () {
        widget.cartController.cart.add(Product(
                category: widget.productController.category,
                image: widget.productController.image,
                title: widget.productController.title,
                description: widget.productController.description,
                price: widget.productController.price,
                favorite: widget.productController.favorite,
                quantity: widget.productController.quantity)
            .toJson());
        widget.cartController.addCartPrice(
            price: widget.productController.price,
            quantity: widget.productController.quantity);
        Navigator.pop(context);
      },
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: Colors.black),
        height: 50,
        width: 220,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Add to Cart',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              Text(
                '\$${(double.parse(widget.productController.price) * widget.productController.quantity).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
