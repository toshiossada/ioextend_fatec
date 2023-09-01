// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      title: map['title'].toString(),
      description: map['description'].toString(),
      price: map['price'].toDouble(),
      image: map['thumbnail'].toString(),
    );
  }
}
