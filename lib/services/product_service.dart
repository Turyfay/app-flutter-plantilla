import 'dart:convert';
import 'dart:io';
import 'package:app_plantilla/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl = 'flutter-va-b109c-default-rtdb.firebaseio.com';
  late final List<Product> products = [];
  File? newPictureFile;
  Product? selectedProduct;
  bool isLoading = true;
  bool isSaving = false;
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

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();
    if (product.id == null) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final response = await http.put(url, body: product.toJson());
    final decodeData = response.body;

    final index = products.indexWhere((p) => p.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.post(url, body: product.toJson());
    final decodeData = json.decode(response.body);
    product.id = decodeData['name'];
    products.add(product);
    return product.id!;
  }

  void updateSelectProductImage(String? imageUrl) {
    selectedProduct!.picture = imageUrl;
    newPictureFile = File.fromUri(Uri.parse(imageUrl!));
    notifyListeners();
  }
}
