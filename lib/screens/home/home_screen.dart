import 'package:flutter/material.dart';
import 'package:flutter_market_app/controllers/category_controller.dart';
import 'package:flutter_market_app/screens/home/widgets/card_balance.dart';
import 'package:flutter_market_app/screens/home/widgets/product_grid_view.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CardBalance(),
              const SizedBox(height: 15),
              categories(context),
              const SizedBox(height: 15),
              ProductGridView(category: categoryController.category),
            ],
          ),
        ),
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      title: const Text('Welcome'),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined)),
        IconButton(
            onPressed: () {},
            icon: const CircleAvatar(child: Icon(Icons.person)))
      ],
    );
  }

  SingleChildScrollView categories(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          categoryCard(context, 'assets/icons/pizza.png', 'Pizza'),
          categoryCard(context, 'assets/icons/japanese.png', 'Japanese'),
        ],
      ),
    );
  }

  Widget categoryCard(BuildContext context, String image, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        child: Ink(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              boxShadow: kElevationToShadow[3],
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).cardColor),
          child: SizedBox(
            width: 70,
            height: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                  width: 45,
                  child: Image.asset(image),
                ),
                Text(title, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
        onTap: () {
          setState(() {
            categoryController.changeCategory(title);
          });
        },
      ),
    );
  }
}
