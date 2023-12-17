import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takyeef/ac_calculator/input_page.dart';
import 'package:takyeef/pages/productDetails_page.dart';
import 'package:takyeef/provider/product.dart';
import 'package:takyeef/provider/products_provider.dart';
import 'package:takyeef/widgets/bottom_button.dart';
import 'package:takyeef/widgets/my_drawer.dart';

class ResultsPage extends StatefulWidget {
  static const routeName = 'resuls_page';
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  

  @override
  Widget build(BuildContext context) {
    final dynamic hPower = ModalRoute.of(context).settings.arguments;
    Provider.of<Products>(context).showRecommendation(hPower);
    final List<Product> prodData =
        Provider.of<Products>(context).recommendedProducts;

    Widget recommend() {
      if (prodData.length > 0) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetailsPage.routeName,
                      arguments: prodData[0].id);
                },
                leading: Image.network(
                  prodData[0].imageUrl,
                  height: 100,
                  width: 80,
                ),
                title: Text(
                  '${prodData[0].title}',
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                subtitle: Text(
                  '${prodData[0].price}',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        );
      } else {
        return Text('');
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Align(
          alignment: Alignment.center,
          child: Text('حساب التكييف المناسب'),
        ),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        ': قدرة التكييف ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        '$hPower',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        'حصان',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          recommend(),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'معلومات تهمك',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'هذه التقديرات تقريبية وتحتاج أيضا للتواصل مع تقني مختص للتأكيد - ',
                    textAlign: TextAlign.end,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'الاثاث يشكل فرق في اختيارك لقوه التكييف فلا تتساوى الغرف الفارغة مع المكتظة بالاشياء -',
                    textAlign: TextAlign.end,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'استخدم تكييف واحد اقوي بدلاً من استخدام 2 مكيف هواء -',
                    textAlign: TextAlign.end,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'حاول استخدام البلاستيك فوق النوافذ والابواب لاحكام الغلق -',
                    textAlign: TextAlign.end,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'يؤخذ في عين الاعتبار طبيعة الجو الصحراوي او الساحلي وخلافة -',
                    textAlign: TextAlign.end,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'يؤخذ في عين الاعتبار كثافة الجدران او الجدران الزجاجية المستخدمة في الواجهات مثلاً -',
                    textAlign: TextAlign.end,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BottomButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InputPage(),
                  ),
                );
              },
              icon: Icons.refresh,
              buttonText: 'إعادة الحساب'),
        ],
      ),
    );
  }
}
