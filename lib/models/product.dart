class Product {
  final String image;
  final String title;
  final String description;
  final double price;
  final bool favorite;

  Product({required this.image, required this.title, required this.description, required this.price, required this.favorite});

  Map<String, dynamic> toMap() => {
    'image': image,
    'title': title,
    'description': description,
    'price': price,
    'favorite' : favorite,
  };
}
