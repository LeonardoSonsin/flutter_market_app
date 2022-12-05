import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_market_app/models/product.dart';

class ProductService {
  CollectionReference<Map<String, dynamic>> db =
      FirebaseFirestore.instance.collection('products');

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

  Future<String> getProductCategory({required String productId}) async {
    var docSnapshot = await db
        .doc('zJJTGhWG79PbVyW49zyz')
        .collection('Favorites')
        .doc(productId)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['category'];
      return value;
    }
    return '';
  }

  void updateFavorite(
      {required String category,
      required String uuid,
      required bool favorite}) {
    db
        .doc('zJJTGhWG79PbVyW49zyz')
        .collection(category)
        .where('uuid', isEqualTo: uuid)
        .get()
        .then((value) =>
            value.docs.single.reference.update({'favorite': favorite}));
  }

  Future createProduct(
      {required String category,
      required String image,
      required String title,
      required String description,
      required String price}) async {
    final docProduct = FirebaseFirestore.instance
        .collection('products')
        .doc('zJJTGhWG79PbVyW49zyz')
        .collection(category)
        .doc();
    final product = Product(
        image: image,
        title: title,
        description: description,
        price: price,
        category: category,
        favorite: false,
        quantity: 1);
    final json = product.toJson();
    await docProduct.set(json);
  }

  Future addFavorite(
      {required String id,
      required String uuid,
      required String category,
      required String image,
      required String title,
      required String description,
      required String price}) async {
    final docProduct = FirebaseFirestore.instance
        .collection('products')
        .doc('zJJTGhWG79PbVyW49zyz')
        .collection('Favorites')
        .doc();
    final product = Product(
        id: id,
        uuid: uuid,
        category: category,
        image: image,
        title: title,
        description: description,
        price: price,
        favorite: true,
        quantity: 1);
    final json = product.toJsonFavorite();
    await docProduct.set(json);
  }

  Future removeFavorite({required String uuid}) async {
    FirebaseFirestore.instance
        .collection('products')
        .doc('zJJTGhWG79PbVyW49zyz')
        .collection('Favorites')
        .where('uuid', isEqualTo: uuid)
        .get()
        .then((value) => value.docs.single.reference.delete());
  }
}
