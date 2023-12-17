import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takyeef/provider/products_provider.dart';
import 'package:takyeef/pages/productDetails_page.dart';

const KDiscountsStyle = TextStyle(
  color: Colors.black87,
  fontSize: 18.0,
);

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final List products = productData.items;
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ProductDetailsPage.routeName,
              arguments: products[index].id);
        },
        child: Card(
          elevation: 5,
          child: ListTile(
            leading: Image.network(
              products[index].imageUrl,
              height: 60,
              width: 60,
            ),
            title: Text(
              products[index].title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF1A2038),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.add_shopping_cart,
                color: Colors.blue,
              ),
            ),
            subtitle: Text(
              'ج.م ${products[index].price}',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
