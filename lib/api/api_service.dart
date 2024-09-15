import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_flutter_api/model/product_model.dart';

class ApiService {
  // get all products
  // return product list so add to the list and productmodel
  static Future<List<ProductModel>> getAllProducts() async {
    const String url = 'https://fakestoreapi.com/products';

    try {
      // should convert url as uri
      final response = await http.get(Uri.parse(url));

      // if we have response
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<ProductModel> products = responseData.map((json) {
          return ProductModel.fromjson(json);
        }).toList();

        return products;
      } else {
        print("failed to get all products: ${response.statusCode}");
        throw Exception("failed to get product");
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to get all products");
    }
  }

  // get one product
  // return only one product
  static Future<ProductModel> getProduct(int id) async {
    final String url = 'https://fakestoreapi.com/products/$id';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        ProductModel product =
            ProductModel.fromjson(json.decode(response.body));
        return product;
      } else {
        print("Failed to fetch product. Status code: ${response.statusCode}");
        throw Exception("Failed to fetch product");
      }
    } catch (e) {
      print(e);
      throw Exception("failed to fetch product");
    }
  }

  // add product

  static Future<ProductModel> addProduct(ProductModel product) async {
    const String url = 'https://fakestoreapi.com/products';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.tojson()),
      );

      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print product as json
        print(response.body);

        // get new product as product
        ProductModel newProduct = ProductModel.fromjson(
          json.decode(response.body),
        );

        return newProduct;
      } else {
        print("Failed to add product. Status code: ${response.statusCode}");
        print(response.body);
        throw Exception("Failed to add product");
      }
    } catch (e) {
      print(e);
      throw Exception("failed to create product");
    }
  }
}
