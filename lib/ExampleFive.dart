import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import 'Models/ProductModel.dart';

class ExampleFive extends StatefulWidget {
  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  Future<ProductModel?> getProductsApi() async {
    final response =
    await http.get(Uri.parse("https://dummyjson.com/products/1"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return ProductModel.fromJson(data);
    } else {
      print('Failed to load product');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: FutureBuilder<ProductModel?>(
        future: getProductsApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            final product = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(product.thumbnail.toString()),
                      SizedBox(height: 10),
                      Text(
                        product.title.toString(),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        product.description.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text('Category: ${product.category}'),
                      SizedBox(height: 10),
                      Text('Brand: ${product.brand}'),
                      SizedBox(height: 10),
                      Text('Price: \$${product.price}'),
                      Text('Discount: ${product.discountPercentage}%'),
                      Text('Rating: ${product.rating}'),
                      Text('Stock: ${product.stock}'),
                      SizedBox(height: 10),
                      Text('SKU: ${product.sku}'),
                      SizedBox(height: 10),
                      Text('Weight: ${product.weight} kg'),
                      SizedBox(height: 10),
                      Text('Dimensions: ${product.dimensions?.width} x ${product.dimensions?.height} x ${product.dimensions?.depth} cm'),
                      SizedBox(height: 10),
                      Text('Warranty: ${product.warrantyInformation}'),
                      Text('Shipping: ${product.shippingInformation}'),
                      Text('Availability: ${product.availabilityStatus}'),
                      SizedBox(height: 10),
                      Text('Return Policy: ${product.returnPolicy}'),
                      SizedBox(height: 10),
                      Text('Minimum Order Quantity: ${product.minimumOrderQuantity}'),
                      SizedBox(height: 20),
                      Text(
                        'Reviews',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ...?product.reviews?.map((review) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          title: Text(review.reviewerName.toString()),
                          subtitle: Text(review.comment.toString()),
                          trailing: Text('Rating: ${review.rating}'),
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
