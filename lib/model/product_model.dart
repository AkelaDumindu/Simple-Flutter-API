class ProductModel {
  final int? id;
  final String name;
  final double price;
  final String category;
  final String description;
  final String image;

  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory ProductModel.fromjson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'title': name,
      'price': price.toDouble(),
      'category': category,
      'description': description,
      'image': image,
    };
  }
}
