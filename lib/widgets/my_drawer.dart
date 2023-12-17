import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takyeef/ac_services/tech_services_page.dart';
import 'package:takyeef/pages/about.dart';
import 'package:takyeef/pages/home_page.dart';
import 'package:takyeef/ac_calculator/input_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1A2038),
        child: ListView(
          children: <Widget>[
            Container(
              height: 250,
              child: Image.asset(
                'images/light_logo.png',
              ),
            ),
            InkWell(
              splashColor: Colors.indigo,
              child: Card(
                color: Color(0xFF1A2038),
                elevation: 3,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  title: Text(
                    'المتجر',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.indigo,
              child: Card(
                color: Color(0xFF1A2038),
                elevation: 3,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(InputPage.routeName);
                  },
                  title: Text(
                    'حسابات التكييف',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.calculator,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.indigo,
              child: Card(
                color: Color(0xFF1A2038),
                elevation: 3,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.of(context).pushNamed(TechServicesPage.routeName);
                  },
                  title: Text(
                    'الفنيين',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.tools,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.indigo,
              child: Card(
                color: Color(0xFF1A2038),
                elevation: 3,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutPage(),
                      ),
                    );
                  },
                  title: Text(
                    'عن التطبيق',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.new_releases,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
