import 'package:flutter/material.dart';
import 'package:simple_flutter_api/api/api_service.dart';
import 'package:simple_flutter_api/model/product_model.dart';
import 'package:simple_flutter_api/sccreens/single_product_page.dart';

class AllProdutsPage extends StatefulWidget {
  const AllProdutsPage({super.key});

  @override
  State<AllProdutsPage> createState() => _AllProdutsPageState();
}

class _AllProdutsPageState extends State<AllProdutsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<ProductModel>>(
          future: ApiService.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No products found"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ProductModel products = snapshot.data![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: ListTile(
                      title: Text(products.name),
                      subtitle: Text("\$${products.price}"),
                      leading: Image.network(
                        products.image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SingleProductPage(productId: products.id!),
                            ));
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
