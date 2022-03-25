import 'package:app_plantilla/utils/UI/input_decorations.dart';
import 'package:app_plantilla/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save_outlined),
          onPressed: () {},
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    const ProductoImage(),
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
                        onPressed: () => {},
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecorations.authInputDecoration(
                    labelText: 'Nombre', hintText: 'Nombre del producto'),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration:
                    InputDecorations.authInputDecoration(labelText: 'Precio'),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),
              SwitchListTile.adaptive(
                  title: const Text('Disponible'),
                  activeColor: Colors.indigo,
                  value: true,
                  onChanged: (value) {}),
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
