import 'package:flutter/material.dart';
import 'package:takyeef/widgets/products_widget.dart';

class MoreProducts extends StatefulWidget {
  static const routeName = 'more_products';
  @override
  _MoreProductsState createState() => _MoreProductsState();
}

class _MoreProductsState extends State<MoreProducts> {
  @override
  Widget build(BuildContext context) {
    final List products = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text('تكييفك'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 8,
          ),
          child: products.length == 0
              ? Text(
                  'No Data Available',
                  style: KDiscountsStyle,
                )
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) => ProductsWidget(
                    index: index,
                  ),
                ),
        ),
      ),
    );
  }
}
