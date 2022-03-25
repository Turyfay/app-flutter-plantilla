import 'package:app_plantilla/models/models.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: _BoxDecoration(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _BackgroundImage(
              image: product.picture,
            ),
            _ProductDetails(
              title: product.name,
              id: product.id!,
            ),
            Positioned(
                top: 0,
                right: 0,
                child: _PriceTag(
                  price: product.price,
                )),
            Positioned(
                top: 0,
                left: 0,
                child: !product.available ? _NoteAvalible() : Container())
          ],
        ),
      ),
    );
  }

  BoxDecoration _BoxDecoration() {
    return BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          spreadRadius: 2,
          offset: Offset(0, 5),
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
    );
  }
}

class _NoteAvalible extends StatelessWidget {
  const _NoteAvalible({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('No disponible',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;
  const _PriceTag({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text('\$$price',
              style: const TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String title;
  final String id;
  const _ProductDetails({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Colors.indigo,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              id,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String? image;
  const _BackgroundImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: 400,
        child: image == null
            ? const Image(
                fit: BoxFit.cover, image: AssetImage('assets/no-image.png'))
            : FadeInImage(
                image: NetworkImage(image!),
                placeholder: const AssetImage('assets/jar-loading.gif'),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
