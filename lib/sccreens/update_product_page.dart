import 'package:flutter/material.dart';
import 'package:simple_flutter_api/api/api_service.dart';
import 'package:simple_flutter_api/model/product_model.dart';

class UpdateProductPage extends StatefulWidget {
  final ProductModel product;
  const UpdateProductPage({super.key, required this.product});

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late double price;
  late String description;
  late String image;
  late String category;

  @override
  void initState() {
    super.initState();
    name = widget.product.name;
    price = widget.product.price;
    description = widget.product.description;
    image = widget.product.image;
    category = widget.product.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue:
                      name, //the value before update that show in the form field
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value!;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: price.toString(),
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    price = double.parse(value!);
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: description,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    description = value!;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: image,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    image = value!;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: category,
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    category = value!;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ProductModel updatedProduct = ProductModel(
                          name: name,
                          price: price,
                          category: category,
                          description: description,
                          image: image,
                        );

                        try {
                          await ApiService.updateProduct(
                              widget.product.id!, updatedProduct);
                          Navigator.pop(context);
                        } catch (e) {
                          print(e.toString());
                        }
                      }
                    },
                    child: Text("Update Product"))
              ],
            )),
      ),
    );
  }
}
