import 'package:flutter/material.dart';
import 'package:simple_flutter_api/api/api_service.dart';
import 'package:simple_flutter_api/model/product_model.dart';
import 'package:simple_flutter_api/sccreens/update_product_page.dart';

class SingleProductPage extends StatelessWidget {
  final int productId;

  const SingleProductPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: ApiService.getProduct(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("Product not found"));
            } else {
              ProductModel product = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.network(
                      product.image,
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Text(product.name, style: const TextStyle(fontSize: 24.0)),
                    const SizedBox(height: 8.0),
                    Text("\$${product.price}",
                        style: const TextStyle(fontSize: 20.0)),
                    const SizedBox(height: 8.0),
                    Text(product.description),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateProductPage(product: product),
                          ),
                        );
                      },
                      child: const Text("Update Product"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await ApiService.deleteProduct(product.id!);
                        Navigator.pop(context);
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
