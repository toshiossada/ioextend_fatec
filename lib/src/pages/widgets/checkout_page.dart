import 'package:flutter/material.dart';
import 'package:lojinha/src/pages/widgets/products_list.dart';

import '../../models/product_model.dart';

class CheckoutPage extends StatelessWidget {
  final List<ProductModel> products;
  const CheckoutPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          if (products.isEmpty)
            const Text('Nenhum produto selecionado')
          else
            ProductsList(products: products)
        ],
      ),
    );
  }
}
