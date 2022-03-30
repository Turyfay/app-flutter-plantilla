import 'package:app_plantilla/models/models.dart';
import 'package:app_plantilla/services/services.dart';
import 'package:app_plantilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //Elimina el boton de volver
        centerTitle: true,
        title: const Text('Productos'),
      ),
      body: ListView.builder(
          itemCount: productService.products.length,
          itemBuilder: (_, index) {
            return GestureDetector(
                onTap: () {
                  productService.selectedProduct =
                      productService.products[index].copy();
                  Navigator.pushNamed(
                    context,
                    '/product',
                  );
                },
                child: ProductCard(product: productService.products[index]));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productService.selectedProduct = Product(
            name: '',
            price: 0,
            available: false,
          );
          Navigator.pushNamed(context, '/product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
