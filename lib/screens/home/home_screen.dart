import 'package:flutter/material.dart';
import 'package:flutter_market_app/screens/home/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(child: Icon(Icons.person)))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProductCard(
                image:
                    'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png',
                title: 'Produto 1',
                description:
                    'Descrição de teste para visualizar a criação do item.',
                price: 10.99,
                favorite: false,
              ),
              ProductCard(
                image:
                    'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png',
                title: 'Produto 2',
                description:
                    'Descrição de teste para visualizar a criação do item.',
                price: 15.99,
                favorite: false,
              ),
              ProductCard(
                image:
                    'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png',
                title: 'Produto 3',
                description:
                    'Descrição de teste para visualizar a criação do item.',
                price: 20.99,
                favorite: false,
              ),
              ProductCard(
                image:
                    'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png',
                title: 'Produto 4',
                description:
                    'Descrição de teste para visualizar a criação do item.',
                price: 30.99,
                favorite: false,
              ),
              ProductCard(
                image:
                    'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png',
                description:
                    'Descrição de teste para visualizar a criação do item.',
                title: 'Produto 5',
                price: 49.99,
                favorite: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
