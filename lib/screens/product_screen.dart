import 'package:app_plantilla/providers/product_form_provider.dart';
import 'package:app_plantilla/services/services.dart';
import 'package:app_plantilla/utils/UI/input_decorations.dart';
import 'package:app_plantilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct!),
      child: _ProductsScreenBody(
        productService: productService,
      ),
    );
    //return _ProductsScreenBody(productService: productService);
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    final ProductFormProvider productFormProvider =
        Provider.of<ProductFormProvider>(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save_outlined),
          onPressed: () async {
            if (!productFormProvider.isValid()) return;
            await productService
                .saveOrCreateProduct(productFormProvider.product);
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            //PkeyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Stack(
                  children: [
                    ProductoImage(url: productService.selectedProduct?.picture),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 40),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 30,
                      child: IconButton(
                        onPressed: () async {
                          final picker = new ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 100);
                          if (pickedFile == null) {
                            print('No se pudo cargar la imagen');
                            return;
                          }

                          print('Se cargo la imagen');
                          productService
                              .updateSelectProductImage(pickedFile?.path);
                        },
                        icon: const Icon(Icons.camera_alt_outlined,
                            color: Colors.white, size: 40),
                      ),
                    )
                  ],
                ),
                const _ProductForm(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ));
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final product = productFormProvider.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es requerido';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    labelText: 'Nombre', hintText: 'Nombre del producto'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: product.price.toString(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) => double.tryParse(value) == null
                    ? product.price = 0
                    : product.price = double.parse(value),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es requerido';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration:
                    InputDecorations.authInputDecoration(labelText: 'Precio'),
              ),
              const SizedBox(height: 30),
              SwitchListTile.adaptive(
                  title: const Text('Disponible'),
                  activeColor: Colors.indigo,
                  value: product.available,
                  onChanged: productFormProvider.updateAvailability),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          spreadRadius: 2,
          offset: Offset(0, 5),
        )
      ],
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
    );
  }
}
