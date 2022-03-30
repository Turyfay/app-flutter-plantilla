import 'dart:io';

import 'package:flutter/material.dart';

class ProductoImage extends StatelessWidget {
  final String? url;
  const ProductoImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            child: getImage(url),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            )
          ]);
}

Widget getImage(String? url) {
  if (url == null) {
    return const Image(
      image: AssetImage('assets/no-image.png'),
      fit: BoxFit.cover,
    );
  }
  if (url.startsWith('http')) {
    return FadeInImage(
      image: NetworkImage(url),
      placeholder: const AssetImage('assets/jar-loading.gif'),
      fit: BoxFit.cover,
    );
  }

  return Image.file(File(url), fit: BoxFit.cover);
}
