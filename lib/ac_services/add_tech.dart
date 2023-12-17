import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:takyeef/ac_calculator/calculator_Field.dart';
import 'package:takyeef/ac_services/add_tech_successful.dart';
import 'package:takyeef/ac_services/tech_form_class.dart';
import 'package:takyeef/widgets/bottom_button.dart';
import 'package:http/http.dart' as http;

class AddNewTech extends StatefulWidget {
  @override
  _AddNewTechState createState() => _AddNewTechState();
}

class _AddNewTechState extends State<AddNewTech> {
  final nameNode = FocusNode();
  final addressNode = FocusNode();
  final regionNode = FocusNode();
  final mobileNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var newTech = TechForm();

  String name;
  String address;
  String region;
  int mobileNo;

  bool isLoading;
  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    } else {
      _form.currentState.save();
      setState(() {
        isLoading = true;
      });
      addTech(
        name,
        address,
        mobileNo,
        region,
      ).then((_) {
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
  }

  Future<void> addTech(
      String name, String address, int mobileNo, String region) async {
    final url =
        'http://tkyeefk.com/api/add_technicians.php/?full_name=$name&address=$address &mobile=$mobileNo &city=$region';
    final response = await http.get(url);
    print(jsonDecode(response.body));

    if (jsonDecode(response.body) == "Done") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TechAddingSuccessful(),
        ),
      );
    } else {
      return;
    }
    return Future.value();
  }

  @override
  void dispose() {
    nameNode.dispose();
    addressNode.dispose();
    regionNode.dispose();
    mobileNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Align(
          alignment: Alignment.center,
          child: Text('إضافة فني جديد'),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  CalcFormField(
                    icon: Icons.person,
                    hintText: '. . . الإسم',
                    keyboardtype: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: nameNode,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    onSubmitted: (value) {
                      name = value;
                      FocusScope.of(context).requestFocus(addressNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'من فضلك ادخل الاسم';
                      } else if (value.length < 8) {
                        return 'الإسم يجب أن لا يقل عن 8 حروف';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      newTech = TechForm(
                        name: value,
                        address: newTech.address,
                        region: newTech.region,
                        mobileNo: newTech.mobileNo,
                      );
                    },
                  ),
                  CalcFormField(
                    icon: Icons.home,
                    hintText: '. . . العنوان',
                    keyboardtype: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: addressNode,
                    onChanged: (value) {
                      setState(() {
                        address = value;
                      });
                    },
                    onSubmitted: (value) {
                      address = value;
                      FocusScope.of(context).requestFocus(regionNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'من فضلك ادخل العنوان';
                      } else if (value.length < 8) {
                        return 'العنوان يجب أن لا يقل عن 15 حرف';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      newTech = TechForm(
                        name: newTech.name,
                        address: value,
                        region: newTech.region,
                        mobileNo: newTech.mobileNo,
                      );
                    },
                  ),
                  CalcFormField(
                    icon: Icons.location_on,
                    hintText: '. . . نطاق العمل',
                    keyboardtype: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: regionNode,
                    onChanged: (value) {
                      setState(() {
                        region = value;
                      });
                    },
                    onSubmitted: (value) {
                      region = value;
                      FocusScope.of(context).requestFocus(mobileNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'من فضلك ادخل المنطقة';
                      } else if (value.length < 3) {
                        return 'المدينة يجب أن لا تقل عن 3 حروف';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      newTech = TechForm(
                        name: newTech.name,
                        address: newTech.address,
                        region: value,
                        mobileNo: newTech.mobileNo,
                      );
                    },
                  ),
                  CalcFormField(
                    icon: Icons.phone_android,
                    hintText: '. . . رقم المحمول',
                    keyboardtype: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    focusNode: mobileNode,
                    onChanged: (value) {
                      setState(() {
                        mobileNo = int.parse(value);
                      });
                    },
                    onSubmitted: (value) {
                      mobileNo = int.parse(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'من فضلك ادخل رقم المحمول';
                      } else if (value.length < 8) {
                        return 'المحمول يجب أن لا يقل عن 11 رقم';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      newTech = TechForm(
                        name: newTech.name,
                        address: newTech.address,
                        region: newTech.region,
                        mobileNo: int.parse(value),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BottomButton(
                      onTap: () {
                        _saveForm();
                      },
                      icon: Icons.save,
                      buttonText: 'حفظ')
                ],
              ),
            ),
    );
  }
}
