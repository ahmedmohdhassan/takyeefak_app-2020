import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takyeef/ac_services/tech_list_provider.dart';
import 'package:takyeef/widgets/techDetails_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TechDetailsPage extends StatefulWidget {
  static const routeName = 'tech_details_page';

  @override
  _TechDetailsPageState createState() => _TechDetailsPageState();
}

class _TechDetailsPageState extends State<TechDetailsPage> {
  Future<void> callNumber(String number) async {
    if (await canLaunch(number)) {
      await launch(number);
    } else {
      throw 'Could not call $number';
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTechId = ModalRoute.of(context).settings.arguments as String;
    final selectedTech = Provider.of<Technicians>(context)
        .items
        .firstWhere((tech) => tech.id == selectedTechId);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Align(
          alignment: Alignment.center,
          child: Text('بيانات الفني'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Material(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          elevation: 7.0,
          shadowColor: Colors.white30,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TechDetails(
                  type: 'الإسم',
                  icon: Icon(Icons.person),
                  detail: '${selectedTech.name}',
                  iconButton: Text(''),
                ),
                TechDetails(
                  type: 'المدينة',
                  icon: Icon(Icons.location_on),
                  detail: '${selectedTech.city}',
                  iconButton: Text(''),
                ),
                TechDetails(
                  type: 'رقم التليفون',
                  icon: Icon(Icons.phone_android),
                  detail: '${selectedTech.mobile}',
                  iconButton: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.call,
                          size: 30,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            callNumber('tel:${selectedTech.mobile}');
                          });
                        },
                      ),
                      Text(
                        'call',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
