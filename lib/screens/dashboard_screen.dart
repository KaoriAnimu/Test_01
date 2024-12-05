// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await productProvider.fetchProducts();
        },
        child: FutureBuilder(
          future: productProvider.fetchProducts(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return Center(child: Text('Gagal untuk memuat ulang produk'));
            } else {
              return ListView.builder(
                itemCount: productProvider.products.length,
                itemBuilder: (ctx, index) {
                  final product = productProvider.products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.description),
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
