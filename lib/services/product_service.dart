import 'dart:convert';
import 'package:app_plantilla/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl = 'flutter-va-b109c-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  ProductService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(response.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }
}
