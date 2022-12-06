import 'package:flutter/material.dart';
import 'package:flutter_market_app/controllers/cart_controller.dart';
import 'package:flutter_market_app/controllers/category_controller.dart';
import 'package:flutter_market_app/controllers/product_controller.dart';
import 'package:flutter_market_app/data/product_service.dart';
import 'package:flutter_market_app/models/product.dart';
import 'package:flutter_market_app/screens/cart/cart_screen.dart';
import 'package:flutter_market_app/screens/product/product_screen.dart';
import 'package:flutter_market_app/themes/theme_colors.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductService productService = ProductService();
  final ScrollController _scrollController = ScrollController();
  final productController = Get.put(ProductController());
  final categoryController = Get.put(CategoryController());
  final cartController = Get.put(CartController());

  double _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      _scrollListener();
    });
    categoryController.category = 'Favorites';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: myAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              categories(context),
              const SizedBox(height: 15),
              productGridView(),
            ],
          ),
        ),
      ),
      floatingActionButton: cartController.cart.isNotEmpty
          ? FloatingActionButton.extended(
              backgroundColor: ThemeColors.blackColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Check out ${cartController.cart.length} products",
                    style: Theme.of(context).textTheme.labelSmall),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const CartScreen(),
                  ),
                ).then((value) => setState(() {}));
              },
            )
          : /*categoryController.category != 'Favorites'
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (builder) => AddProductScreen(
                            category: categoryController.category),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                )
              :*/
          null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar myAppBar() {
    return AppBar(
      toolbarHeight: _scrollPosition == 0 ? 150 : 67,
      backgroundColor: ThemeColors.blackColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: _scrollPosition == 0
              ? const BorderRadius.vertical(bottom: Radius.circular(25.0))
              : BorderRadius.circular(0)),
      flexibleSpace: SafeArea(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          margin: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('MarketApp',
                      style: Theme.of(context).textTheme.titleLarge),
                  InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const CartScreen()))
                          .then((value) => setState(() {}));
                    },
                    child: Ink(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                          color: ThemeColors.greenColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.shopping_cart_outlined),
                          Text('${cartController.cart.length}',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _scrollPosition == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextField(
                        autofocus: false,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white70,
                            fontSize: 14.0),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          prefixIcon: const Icon(Icons.search,
                              color: ThemeColors.greyAccent),
                          filled: true,
                          fillColor: ThemeColors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: ThemeColors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: ThemeColors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Search for something tasty...',
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    )
                  : const SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }

  Column categories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Top Categories',
                style: Theme.of(context).textTheme.titleMedium),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Text('View all',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(width: 5),
                  const Icon(Icons.arrow_forward_outlined,
                      color: ThemeColors.greyAccent, size: 25)
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              categoryCard(context, 'assets/icons/favorite.png', 'Favorites'),
              categoryCard(context, 'assets/icons/pizza.png', 'Pizza'),
              categoryCard(context, 'assets/icons/japanese.png', 'Japanese'),
              categoryCard(context, 'assets/icons/burger.png', 'Burger'),
              categoryCard(context, 'assets/icons/drinks.png', 'Drinks'),
              categoryCard(context, 'assets/icons/dessert.png', 'Desserts'),
            ],
          ),
        ),
      ],
    );
  }

  Widget categoryCard(BuildContext context, String image, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        child: Ink(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: categoryController.category == title
                  ? ThemeColors.greenColor
                  : Colors.white),
          child: SizedBox(
            width: 100,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                  width: 25,
                  child: Image.asset(image, color: Colors.black),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
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

  Container productPrice(Product product) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(right: 16.0),
      child: Text('\$${product.price}', style: const TextStyle(fontSize: 16.0)),
    );
  }

  Padding productTitle(Product product) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Text(product.title, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
    );
  }

  Widget productImage(Product product) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: Image.network(
            product.image,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Image.asset('assets/images/image-error.png', scale: 2.5),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildProductCard(Product product) => InkWell(
        borderRadius: BorderRadius.circular(15.0),
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Theme.of(context).cardColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productImage(product),
              productTitle(product),
              productPrice(product),
            ],
          ),
        ),
        onTap: () {
          productController.buildProductController(
              id: product.id,
              uuid: product.uuid,
              image: product.image,
              title: product.title,
              description: product.description,
              price: product.price,
              category: product.category,
              productController: productController,
              favorite: product.favorite,
              quantity: product.quantity);
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              isScrollControlled: true,
              context: context,
              builder: (builder) => ProductScreen(
                  productController: productController,
                  cartController: cartController,
                  category: productController.category)).then(
            (value) => setState(() {}),
          );
        },
      );

  StreamBuilder productGridView() {
    return StreamBuilder<List<Product>>(
        stream: productService.getProducts(categoryController.category),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;
            if (products.isNotEmpty) {
              return GridView.count(
                  childAspectRatio: 0.95,
                  mainAxisSpacing: 16.0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  children: products.map(buildProductCard).toList());
            }
            if (products.isEmpty &&
                categoryController.category == 'Favorites') {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text('You do not have any favorite items  :('),
                ),
              );
            }
          }
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: ThemeColors.greenColor),
            ),
          );
        });
  }
}
