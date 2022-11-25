import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_market_app/models/product.dart';

class FavoriteService {
  CollectionReference<Map<String, dynamic>> db =
      FirebaseFirestore.instance.collection('favorites');

  Stream<List<Product>> getFavorites() =>
      db.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Product.fromJson(doc.data(), doc.id))
          .toList());

  Future addFavorite(
      {required String uuid,
      required String image,
      required String title,
      required String description,
      required String price}) async {
    final docFavorites = db.doc();
    final product = Product(
        uuid: uuid,
        image: image,
        title: title,
        description: description,
        price: price,
        favorite: true);
    final json = product.toJsonFavorite();
    await docFavorites.set(json);
  }

  Future removeFavorite({required String productUuid}) async {
    db
        .where('uuid', isEqualTo: productUuid)
        .get()
        .then((value) => value.docs.single.reference.delete());
  }
}
