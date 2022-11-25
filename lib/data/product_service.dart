import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_market_app/models/product.dart';

class ProductService {
  CollectionReference<Map<String, dynamic>> db =
      FirebaseFirestore.instance.collection('products');

  Stream<List<Product>> getCategory() =>
      db.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Product.fromJson(doc.data(), doc.id))
          .toList());

  Stream<List<Product>> getProducts(String category) => db
      .doc('zJJTGhWG79PbVyW49zyz')
      .collection(category)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Product.fromJson(doc.data(), doc.id))
          .toList());

  Future<bool> isFavorite(
      {required String category, required String productId}) async {
    var docSnapshot = await db
        .doc('zJJTGhWG79PbVyW49zyz')
        .collection(category)
        .doc(productId)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['favorite'];
      return value;
    }
    return false;
  }

  void updateFavorite(
      {required String category,
      required String productId,
      required bool favorite}) {
    db
        .doc('zJJTGhWG79PbVyW49zyz')
        .collection(category)
        .doc(productId)
        .update({'favorite': favorite});
  }
}
