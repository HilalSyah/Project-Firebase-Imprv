import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs; // Menyimpan list item dalam keranjang
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Menambahkan item ke keranjang dan menyimpan data ke Firestore
  void addToCart(String name, double price, String imageUrl) {
    cartItems.add(CartItem(
      name: name,
      price: price,
      imageUrl: imageUrl,
    ));

    // Menyimpan data ke Firestore
    firestore.collection('cart').add({
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    }).catchError((e) {
      print('Error adding item to Firestore: $e');
    });
  }

  // Menghapus item dari keranjang dan dari Firestore
  void removeFromCart(CartItem cartItem) {
    cartItems.remove(cartItem);

    // Menghapus item dari Firestore berdasarkan 'name'
    firestore
        .collection('cart')
        .where('name', isEqualTo: cartItem.name)
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        firestore.collection('cart').doc(doc.id).delete();
      }
    });
  }

  // Mengambil item dari Firestore dan menambahkannya ke dalam list cartItems
  Future<void> fetchCartItems() async {
    try {
      final snapshot = await firestore.collection('cart').get();
      cartItems.clear(); // Clear existing items
      for (var doc in snapshot.docs) {
        cartItems.add(CartItem(
          name: doc['name'],
          price: doc['price'],
          imageUrl: doc['imageUrl'],
        ));
      }
      print('Cart items fetched: ${cartItems.length}'); // Debugging line
    } catch (e) {
      print("Failed to fetch cart items: $e");
    }
  }
}

// Model untuk item dalam keranjang belanja
class CartItem {
  final String name;
  final double price;
  final String imageUrl;

  CartItem({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}