import 'package:flutter/material.dart';
import 'package:flutter_market_app/controllers/cart_controller.dart';
import 'package:flutter_market_app/models/product.dart';
import 'package:flutter_market_app/themes/theme_colors.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.put(CartController());
  double promo = 0;
  double subtotal = 0;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cart = cartController.cart;
    total = cartController.total;
    subtotal = total + promo;

    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.blackColor,
        elevation: 0,
        title: Text('Cart', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            onPressed: () {
              if (cartController.cart.isNotEmpty) {
                resetCart();
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.52,
            child: cartController.cart.isEmpty
                ? emptyCartText(context)
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      Product product = Product(
                          category: cart[index]['category'],
                          image: cart[index]['image'],
                          title: cart[index]['title'],
                          description: cart[index]['description'],
                          price: cart[index]['price'],
                          favorite: cart[index]['favorite'],
                          quantity: cart[index]['quantity']);
                      return productCard(product, context, cart, index);
                    },
                    itemCount: cartController.cart.length),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            height: MediaQuery.of(context).size.height * 0.48 - 120,
            color: ThemeColors.backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('PROM0C0D&'),
                        InkWell(
                          onTap: () {
                            if (promo < 10 && cartController.cart.isNotEmpty) {
                              promo = 10;
                              cartController.total -= 10;
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 24.0),
                            decoration: BoxDecoration(
                              color: ThemeColors.greenColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text('Confirm'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text(
                          cart.isEmpty
                              ? '\$0.00'
                              : '\$${subtotal.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Promocode',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('\$${promo.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(
                          cart.isEmpty
                              ? '\$0.00'
                              : '\$${total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: InkWell(
                    onTap: () {
                      if (cartController.cart.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              'Order sent!',
                              style: TextStyle(color: Colors.black),
                            ),
                            content: const Text(
                                'Your order has been sent to the kitchen.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Ok',
                                  style:
                                      TextStyle(color: ThemeColors.greenColor),
                                ),
                              )
                            ],
                          ),
                        ).then((value) {
                          Navigator.of(context).pop();
                          resetCart();
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: ThemeColors.blackColor,
                      ),
                      alignment: Alignment.center,
                      child: Text('Order',
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void resetCart() {
    cartController.cart = [];
    cartController.resetCartPrice();
    promo = 0;
    setState(() {});
  }

  Center emptyCartText(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Your shopping cart is empty  :(',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 50,
              width: 175,
              decoration: BoxDecoration(
                color: ThemeColors.blackColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Text('Add product',
                  style: Theme.of(context).textTheme.labelSmall),
            ),
          )
        ],
      ),
    );
  }

  Container productCard(Product product, BuildContext context,
      List<Map<String, dynamic>> cart, int index) {
    return Container(
      height: 150,
      margin:
          const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 120,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: 215,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(product.category,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      height: 35,
                      width: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              cart[index]['quantity'] == 1
                                  ? cart.removeAt(index)
                                  : cart[index]['quantity'] =
                                      cart[index]['quantity'] - 1;
                              cartController.removeCartPrice(
                                  price: product.price);
                              setState(() {});
                            },
                            icon: const Icon(Icons.remove, size: 12),
                          ),
                          Text('${product.quantity}',
                              style: Theme.of(context).textTheme.bodyMedium),
                          IconButton(
                            onPressed: () {
                              if (cart[index]['quantity'] < 10) {
                                cart[index]['quantity'] =
                                    cart[index]['quantity'] + 1;
                                cartController.addCartPrice(
                                    price: product.price, quantity: 1);
                              }
                              setState(() {});
                            },
                            icon: const Icon(Icons.add, size: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                          '\$${(double.parse(product.price) * product.quantity).toStringAsFixed(2)}'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
