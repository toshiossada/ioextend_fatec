import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lojinha/dummy.dart';
import 'package:lojinha/src/models/product_model.dart';
import 'package:lojinha/src/pages/widgets/checkout_page.dart';

import 'widgets/products_grid.dart';
import 'widgets/products_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var lstProducts = <ProductModel>[];
  var lstProductsFiltered = <ProductModel>[];
  var cart = <ProductModel>[];
  var visualization = 0;
  final txtSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    lstProducts = await getProductsExternal();
    lstProductsFiltered = lstProducts;
    setState(() {});
  }

  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    final lastProducts = products['products'] as List<Map<String, dynamic>>;
    final productModels =
        lastProducts.map((e) => ProductModel.fromMap(e)).toList();

    return productModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                controller: txtSearch,
                leading: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onSubmitted: (text) {
                  lstProductsFiltered = lstProducts
                      .where((element) => element.title
                          .toLowerCase()
                          .contains(text.toLowerCase()))
                      .toList();
                  setState(() {});
                },
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    lstProductsFiltered = lstProducts;
                    txtSearch.clear();
                  });
                },
                icon: const Icon(Icons.clear)),
            IconButton(
              onPressed: () {
                setState(() {
                  cart.clear();
                });
              },
              icon: const Icon(Icons.remove_shopping_cart),
            ),
          ],
        ),
        body: (lstProducts.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
                    children: [
                      RadioMenuButton<int>(
                        value: 0,
                        groupValue: visualization,
                        onChanged: (value) {
                          setState(() {
                            visualization = value ?? 0;
                          });
                        },
                        child: const Text('Grid'),
                      ),
                      RadioMenuButton<int>(
                        value: 1,
                        groupValue: visualization,
                        onChanged: (value) {
                          setState(() {
                            visualization = value ?? 1;
                          });
                        },
                        child: const Text('List'),
                      ),
                    ],
                  ),
                  if (visualization == 0)
                    ProductsGrid(
                      products: lstProductsFiltered,
                      onProductSelected: onProductSelected,
                    )
                  else
                    ProductsList(
                      products: lstProductsFiltered,
                      onProductSelected: onProductSelected,
                    )
                ],
              ),
        floatingActionButton: Badge(
          isLabelVisible: cart.isNotEmpty,
          label: Text(cart.length.toString()),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CheckoutPage(products: cart)));
            },
            child: const Icon(Icons.shopping_cart_checkout),
          ),
        ));
  }

  void onProductSelected(ProductModel product, bool added) {
    if (!cart.any((element) => element.id == product.id)) {
      setState(() {
        cart.add(product);
      });
    }
  }

  Future<List<ProductModel>> getProductsExternal() async {
    final dio = Dio();
    final result = await dio.get('https://dummyjson.com/products');

    final lastProducts = result.data['products'] as List;
    final productModels =
        lastProducts.map((e) => ProductModel.fromMap(e)).toList();

    return productModels;
  }
}
