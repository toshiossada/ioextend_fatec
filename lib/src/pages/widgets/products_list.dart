import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../details_page.dart';

class ProductsList extends StatelessWidget {
  final List<ProductModel> products;
  final Function(ProductModel, bool)? onProductSelected;

  const ProductsList(
      {super.key, required this.products, this.onProductSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];
          return GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DetailsPage(product: product)));
              onProductSelected?.call(product, result ?? false);
            },
            child: Container(
                color: index.isEven
                    ? Colors.black.withOpacity(0.1)
                    : Colors.black.withOpacity(0.4),
                child: ListTile(
                  title: Text(product.title),
                  leading: Text('#${product.id.toString()}'),
                  subtitle: Text(product.description),
                  trailing: Column(
                    children: [
                      Text(product.price.toString()),
                      Image.network(
                        product.image,
                        height: 20,
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
