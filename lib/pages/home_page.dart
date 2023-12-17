import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takyeef/ads/ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:takyeef/pages/companies_products.dart';
import 'package:takyeef/pages/more.dart';
import 'package:takyeef/provider/products_provider.dart';
import 'package:takyeef/widgets/actype.dart';
import 'package:takyeef/widgets/discount_widget.dart';
import 'package:takyeef/widgets/my_drawer.dart';
import 'package:takyeef/widgets/products_widget.dart';

const KDiscountsStyle = TextStyle(
  color: Colors.black87,
  fontSize: 18.0,
);

class HomePage extends StatefulWidget {
  static const routeName = 'home_Page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isInite = true;
  bool isLoading;

  @override
  void initState() {
    isLoading = true;
    getAdData();
    super.initState();
  }

  String id;
  String text;
  String imageUrl;
  String targetUrl;

  Future getAdData() async {
    CreateAd _createAd = CreateAd(url: 'http://tkyeefk.com/api/ads.php');
    var adData = await _createAd.fetchad();

    id = adData[0]['ads_id'];
    text = adData[0]['ads_text'];
    imageUrl = adData[0]['ads_img'];
    targetUrl = adData[0]['ads_url'];
  }

  @override
  void didChangeDependencies() {
    if (isInite) {
      Provider.of<Products>(context).fetchNewProducts().catchError((error) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('خطأ في الاتصال'),
            content: Text('تأكد من الاتصال بالانترنت'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'),
              )
            ],
          ),
        );
      });
      Provider.of<Products>(context)
          .fetchDiscountProducts()
          .catchError((error) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('خطأ في الاتصال'),
            content: Text('تأكد من الاتصال بالانترنت'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'),
              )
            ],
          ),
        );
      });
      Provider.of<Products>(context).fetchCategories().then((_) {
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('خطأ في الاتصال'),
            content: Text('تأكد من الاتصال بالانترنت'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'),
              )
            ],
          ),
        );
      });
    }

    isInite = false;

    super.didChangeDependencies();
  }

  Widget _showAd() {
    if (id == null) {
      return Text('');
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            _launchURL();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
    }
  }

  Future<void> _launchURL() async {
    final url = targetUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final productData = Provider.of<Products>(context);
    final List products = productData.items;
    final List discountProducts = productData.discountItems;
    final List acCategories = productData.acCategory;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text('تكييفك'),
        ),
      ),
      drawer: MyDrawer(),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 60.0,
                    width: width,
                    child: acCategories.length == 0
                        ? Text(
                            'No categories right now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          )
                        : ListView.builder(
                            itemCount: acCategories.length,
                            itemBuilder: (context, i) => ACType(
                              type: '${acCategories[i].name}',
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    CompanyProducts.routeName,
                                    arguments: acCategories[i].id);
                              },
                            ),
                            scrollDirection: Axis.horizontal,
                          ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Container(
                      height: height - 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'التخفيضات و العروض',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Color(0xFF1A2038),
                                    fontSize: 22,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.menu,
                                    color: Color(0xFF1A2038),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 300,
                            color: Colors.white,
                            child: discountProducts.length == 0
                                ? Center(
                                    child: Text(
                                      'No Data Available',
                                      style: KDiscountsStyle,
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: discountProducts.length,
                                    itemBuilder: (context, index) =>
                                        DiscountWidget(
                                      index: index,
                                    ),
                                  ),
                          ),
                          _showAd(),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 30,
                              bottom: 10,
                              left: 30,
                              top: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Icon(
                                        Icons.arrow_left,
                                        color: Color(0xFF1A2038),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          MoreProducts.routeName,
                                          arguments: products,
                                        );
                                      },
                                      child: Text(
                                        'المزيد',
                                        style: TextStyle(
                                          color: Color(0xFF1A2038),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'وصل حديثا',
                                      style: TextStyle(
                                        color: Color(0xFF1A2038),
                                        fontSize: 22,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Icon(
                                        Icons.menu,
                                        color: Color(0xFF1A2038),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: height,
                            child: products.length == 0
                                ? Text(
                                    'No Data Available',
                                    style: KDiscountsStyle,
                                  )
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 6,
                                    itemBuilder: (context, index) =>
                                        ProductsWidget(
                                      index: index,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
