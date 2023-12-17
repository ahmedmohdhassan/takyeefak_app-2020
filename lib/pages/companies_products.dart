import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takyeef/pages/productDetails_page.dart';
import 'package:takyeef/provider/product.dart';
import 'package:takyeef/provider/products_provider.dart';

class CompanyProducts extends StatefulWidget {
  static const routeName = 'company_products';
  @override
  _CompanyProductsState createState() => _CompanyProductsState();
}

class _CompanyProductsState extends State<CompanyProducts> {
  var isInite = true;
  bool isLoading;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInite) {
      final selectedComId = ModalRoute.of(context).settings.arguments as String;
      Provider.of<Products>(context)
          .fetchCompaniesProducts(selectedComId)
          .then((_) {
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
      Provider.of<Products>(context).fetchCategories().catchError((error) {
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

  @override
  Widget build(BuildContext context) {
    final selectedComId = ModalRoute.of(context).settings.arguments as String;
    List<Product> companyProducts =
        Provider.of<Products>(context).companyProducts;
    var category = Provider.of<Products>(context)
        .acCategory
        .firstWhere((prod) => prod.id == selectedComId);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            '${category.name}',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: companyProducts.length,
              itemBuilder: (context, index) => companyProducts.length == 0
                  ? Center(
                      child: Text(
                        'no data available ...',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ProductDetailsPage.routeName,
                            arguments: companyProducts[index].id);
                      },
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Image.network(
                            companyProducts[index].imageUrl,
                            height: 50,
                            width: 50,
                          ),
                          title: Text(
                            companyProducts[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF1A2038),
                            ),
                          ),
                          subtitle: Text(
                            companyProducts[index].price,
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}
