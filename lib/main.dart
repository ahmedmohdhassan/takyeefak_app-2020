import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takyeef/ac_calculator/input_page.dart';
import 'package:takyeef/ac_calculator/results_page.dart';
import 'package:takyeef/ac_services/tech_details_page.dart';
import 'package:takyeef/ac_services/tech_list_provider.dart';
import 'package:takyeef/ac_services/tech_services_page.dart';
import 'package:takyeef/pages/companies_products.dart';
import 'package:takyeef/pages/discountDetails_page.dart';
import 'package:takyeef/pages/home_page.dart';
import 'package:takyeef/pages/more.dart';
import 'package:takyeef/pages/productDetails_page.dart';
import 'package:takyeef/pages/order_page.dart';
import 'package:takyeef/pages/ordersuccessful_page.dart';
import 'package:takyeef/provider/products_provider.dart';

void main() => runApp(Takyeef());

class Takyeef extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Technicians(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Almarai',
          scaffoldBackgroundColor: Color(0xFF1A2038),
        ),
        home: HomePage(),
        routes: {
          ProductDetailsPage.routeName: (context) => ProductDetailsPage(),
          DiscountsDetailsPage.routeName: (context) => DiscountsDetailsPage(),
          MoreProducts.routeName: (context) => MoreProducts(),
          CompanyProducts.routeName: (context) => CompanyProducts(),
          OrderPage.routeName: (context) => OrderPage(),
          OrderSuccessful.routeName: (context) => OrderSuccessful(),
          InputPage.routeName: (context) => InputPage(),
          ResultsPage.routeName: (context) => ResultsPage(),
          TechServicesPage.routeName: (context) => TechServicesPage(),
          TechDetailsPage.routeName: (context) => TechDetailsPage(),
        },
      ),
    );
  }
}
