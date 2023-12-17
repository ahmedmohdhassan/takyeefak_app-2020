import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takyeef/provider/products_provider.dart';
import 'package:takyeef/pages/discountDetails_page.dart';

const KDiscountsStyle = TextStyle(
  color: Colors.black87,
  fontSize: 18.0,
);

class DiscountWidget extends StatelessWidget {
  final int index;
  DiscountWidget({
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final List discountProducts = productData.discountItems;
    return Center(
      child: Container(
        width: 350,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(DiscountsDetailsPage.routeName,
                arguments: discountProducts[index].id);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Center(
                    child: Image.network(
                      discountProducts[index].imageUrl,
                      fit: BoxFit.contain,
                      height: 200,
                      width: 300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    discountProducts[index].title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                    style: KDiscountsStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${discountProducts[index].hPower} حصان',
                    textDirection: TextDirection.rtl,
                    style: KDiscountsStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      discountProducts[index].price,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      'بدلاً من',
                      style: KDiscountsStyle,
                    ),
                    SizedBox(width: 15),
                    Text(
                      discountProducts[index].priceDiscount,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      ':السعر',
                      style: KDiscountsStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
