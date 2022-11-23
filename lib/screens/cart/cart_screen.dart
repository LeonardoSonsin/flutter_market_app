import 'package:flutter/material.dart';
import 'package:flutter_market_app/controllers/cart_controller.dart';
import 'package:flutter_market_app/models/product.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cart = cartController.cart;
    double total = cartController.total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
              onPressed: () {
                cartController.cart = [];
                cartController.resetCartPrice();
                setState(() {});
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  Product product = Product(
                      image: cart[index]['image'],
                      title: cart[index]['title'],
                      description: cart[index]['description'],
                      price: cart[index]['price'],
                      favorite: cart[index]['favorite']);
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
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cart.removeAt(index);
                                    cartController.removeCartPrice(
                                        price: product.price);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                const Text('1'),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: cartController.cart.length),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Total'),
              Text(cart.isEmpty ? '\$0.00' : '\$${total.toStringAsFixed(2)}'),
            ],
          )
        ],
      ),
    );
  }
}
