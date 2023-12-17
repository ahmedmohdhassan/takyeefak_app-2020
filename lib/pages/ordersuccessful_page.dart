import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takyeef/pages/home_page.dart';
import 'package:takyeef/widgets/bottom_button.dart';
import 'package:takyeef/widgets/my_drawer.dart';

class OrderSuccessful extends StatelessWidget {
  static const routeName = 'ordersuccessful_page';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xFF1A2038),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 5 / 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.shoppingBag,
                          size: 150,
                          color: Color(0xFF1A2038),
                        ),
                      ),
                      Text(
                        'تمت عملية الطلب بنجاح',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1A2038),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "سيقوم مندوب الشركة بالتواصل معك\n خلال 3 ساعات من الآن لاكمال طلبك ودفع قيمة مقدم الحجز وباقي القيمةيتم دفعها عند الاستلام",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF1A2038),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BottomButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  icon: Icons.refresh,
                  buttonText: 'العوده الى الرئيسية')
            ],
          ),
        ),
      ),
    );
  }
}
