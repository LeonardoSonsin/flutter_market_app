import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String uuid;
  final String image;
  final String title;
  final String description;
  final String price;
  final bool favorite;

  Product(
      {this.id = '',
      this.uuid = '',
      required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.favorite});

  Map<String, dynamic> toJson() => {
        'uuid': const Uuid().v1(),
        'image': image,
        'title': title,
        'description': description,
        'price': price,
        'favorite': favorite,
      };

  Map<String, dynamic> toJsonFavorite() => {
        'uuid': uuid,
        'image': image,
        'title': title,
        'description': description,
        'price': price,
        'favorite': favorite,
      };

  static Product fromJson(Map<String, dynamic> json, String id) => Product(
        id: id,
        uuid: json['uuid'],
        image: json['image'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        favorite: json['favorite'],
      );
}
