import 'package:flutter/material.dart';
import 'package:lojinha/src/models/product_model.dart';

class DetailsPage extends StatelessWidget {
  final ProductModel product;

  const DetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('#${product.id.toString()}'),
      ),
      body: Column(
        children: [
          Text(product.title),
          Text(product.description),
          Text(product.price.toString()),
          Image.network(product.image),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
