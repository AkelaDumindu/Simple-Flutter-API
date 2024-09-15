import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_flutter_api/model/product_model.dart';

class ApiService {
  // get all products
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
}
