import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takyeef/pages/order_page.dart';
import 'package:takyeef/widgets/bottom_button.dart';
import 'package:takyeef/provider/products_provider.dart';

const KDiscountsStyle = TextStyle(
  color: Color(0xFF1A2038),
  fontWeight: FontWeight.w900,
  fontSize: 20.0,
);
const KDetailsStyle = TextStyle(
  color: Color(0xFF1A2038),
  fontWeight: FontWeight.w600,
  fontSize: 16.0,
);

class DiscountsDetailsPage extends StatelessWidget {
  static const routeName = 'discountDetails_page';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final prodId = ModalRoute.of(context).settings.arguments as String;
    final selectedProduct = Provider.of<Products>(context)
        .discountItems
        .firstWhere((prod) => prod.id == prodId);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                child: Container(
                  height: height * 5 / 6,
                  color: Colors.white,
                  child: ListView(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  selectedProduct.imageUrl,
                                ),
                                fit: BoxFit.contain),
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.arrow_back),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              selectedProduct.title,
                              softWrap: true,
                              textAlign: TextAlign.end,
                              style: KDiscountsStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'حصان',
                                  style: KDiscountsStyle,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '${selectedProduct.hPower}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  ':قدرة التكييف',
                                  style: KDiscountsStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  selectedProduct.price,
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
                                  selectedProduct.priceDiscount,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                ' ${selectedProduct.coolWarm}',
                                textAlign: TextAlign.end,
                                style: KDetailsStyle,
                              ),
                              Text(
                                '${selectedProduct.coolCapacity} :سعة التبريد',
                                textAlign: TextAlign.end,
                                style: KDetailsStyle,
                              ),
                              Text(
                                '${selectedProduct.warmCapacity} :سعة التدفئة',
                                textAlign: TextAlign.end,
                                style: KDetailsStyle,
                              ),
                              Text(
                                'اللون: ${selectedProduct.color}',
                                textAlign: TextAlign.end,
                                textDirection: TextDirection.rtl,
                                style: KDetailsStyle,
                              ),
                              Text(
                                'مزود بتكنولوجيا: ${selectedProduct.technology}',
                                textAlign: TextAlign.end,
                                style: KDetailsStyle,
                              ),
                              Text(
                                ' بلد المنشأ: ${selectedProduct.madeIn}',
                                textAlign: TextAlign.end,
                                style: KDetailsStyle,
                              ),
                              Text(
                                selectedProduct.guarantee,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.end,
                                style: KDetailsStyle,
                              ),
                              Text(
                                selectedProduct.description,
                                softWrap: true,
                                textDirection: TextDirection.rtl,
                                style: KDetailsStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BottomButton(
                  onTap: () {
                    Navigator.of(context).pushNamed(OrderPage.routeName,
                        arguments: selectedProduct.id);
                  },
                  icon: Icons.add_shopping_cart,
                  buttonText: 'اطلب الآن'),
            ],
          ),
        ),
      ),
    );
  }
}
