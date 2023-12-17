import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takyeef/ac_services/add_tech.dart';
import 'package:takyeef/ac_services/tech_details_page.dart';
import 'package:takyeef/ac_services/tech_list_provider.dart';
import 'package:takyeef/widgets/my_drawer.dart';

class TechServicesPage extends StatefulWidget {
  static const routeName = 'tec_services_page';

  @override
  _TechServicesPageState createState() => _TechServicesPageState();
}

class _TechServicesPageState extends State<TechServicesPage> {
  bool isInite = true;
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
      Provider.of<Technicians>(context).fetchTechs().then((_) {
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

  @override
  Widget build(BuildContext context) {
    final techData = Provider.of<Technicians>(context);
    final List technicians = techData.items;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Align(
            alignment: Alignment.center,
            child: Text('خدمات التركيب'),
          ),
        ),
        drawer: MyDrawer(),
        body: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddNewTech(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFF1A2038),
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(Icons.add, size: 35)),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'تسجيل فني جديد',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Icon(Icons.person_add),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      child: ListView.builder(
                        itemCount: technicians.length,
                        itemBuilder: (context, index) => technicians.length == 0
                            ? Center(
                                child: Text(
                                  'No Data Available',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, TechDetailsPage.routeName,
                                        arguments: technicians[index].id);
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      leading: Image.asset(
                                        'images/worker.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                      trailing:
                                          Text(' ${technicians[index].city}'),
                                      title: Text(
                                        technicians[index].name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        technicians[index].address,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
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
