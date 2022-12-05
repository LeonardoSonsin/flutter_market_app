import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String uuid;
  final String category;
  final String image;
  final String title;
  final String description;
  final String price;
  final bool favorite;
  final int quantity;

  Product(
      {this.id = '',
      this.uuid = '',
      required this.category,
      required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.favorite,
      required this.quantity});

  Map<String, dynamic> toJson() => {
        'uuid': const Uuid().v1(),
        'image': image,
        'category': category,
        'title': title,
        'description': description,
        'price': price,
        'favorite': favorite,
        'quantity': quantity,
      };

  Map<String, dynamic> toJsonFavorite() => {
        'uuid': uuid,
        'category': category,
        'image': image,
        'title': title,
        'description': description,
        'price': price,
        'favorite': favorite,
        'quantity': quantity,
      };

  static Product fromJson(Map<String, dynamic> json, String id) => Product(
      id: id,
      uuid: json['uuid'],
      category: json['category'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      favorite: json['favorite'],
      quantity: json['quantity']);
}
