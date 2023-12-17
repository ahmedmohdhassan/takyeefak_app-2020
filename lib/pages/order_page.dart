import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:takyeef/pages/ordersuccessful_page.dart';
import 'package:takyeef/widgets/bottom_button.dart';
import 'package:takyeef/widgets/custom_formfield.dart';
import 'package:takyeef/widgets/customerForm_class.dart';

const KDiscountsStyle = TextStyle(
  color: Color(0xFF1A2038),
  fontWeight: FontWeight.w900,
  fontSize: 20.0,
);

class OrderPage extends StatefulWidget {
  static const routeName = 'order_page';

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final nameNode = FocusNode();
  final mobileNode = FocusNode();
  final phoneNode = FocusNode();
  final addressNode = FocusNode();
  final timeNode = FocusNode();
  final quantityNode = FocusNode();
  final cityNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var newForm = CustomerForm(
    name: '',
    mobile: null,
    phone: null,
    address: '',
    callTime: '',
  );
  String customerName;
  int customerMobile;
  int customerPhone;
  String customerAddress;
  String customerCity;
  String customerTime;
  int customerQuantity;
  String productId;

  bool isLoading;
  void _saveForm() {
    var isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      _formKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      orderRequest(
        customerName,
        customerAddress,
        customerMobile,
        customerPhone,
        productId,
        customerQuantity,
        customerCity,
        customerTime,
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

  Future<void> orderRequest(String name, String address, int mobileNo,
      int phoneNo, String id, int quantity, String city, String time) async {
    final url =
        'http://tkyeefk.com/api/order.php/?full_name=$name&address=$address&mobile=$mobileNo&phone=$phoneNo&city=$city&time$time=&product_id=$id&quantity=$quantity';
    final response = await http.get(url);
    print(jsonDecode(response.body));
    print(response.statusCode);

    if (jsonDecode(response.body) == "Done") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderSuccessful(),
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
    mobileNode.dispose();
    phoneNode.dispose();
    addressNode.dispose();
    timeNode.dispose();
    quantityNode.dispose();
    cityNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedProductId =
        ModalRoute.of(context).settings.arguments as String;
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
          title: Text(
            'طلب تكييف',
            style: TextStyle(
              color: Color(0xFF1A2038),
              fontSize: 25.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: height * 5 / 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView(
                            children: [
                              CustomFormField(
                                focusNode: nameNode,
                                icon: Icons.person_outline,
                                hintText: '. . .  الإسم',
                                keyboardtype: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return ' . . . من افضلك ادخل الإسم';
                                  } else if (value.length < 8) {
                                    return ' . . . الاسم لا يقل عن 8 احرف';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    customerName = value;
                                  });
                                },
                                onSubmitted: (value) {
                                  customerName = value;
                                  FocusScope.of(context)
                                      .requestFocus(mobileNode);
                                },
                                onSaved: (value) {
                                  newForm = CustomerForm(
                                    name: value,
                                    mobile: newForm.mobile,
                                    phone: newForm.phone,
                                    address: newForm.address,
                                    callTime: newForm.callTime,
                                  );
                                },
                              ),
                              CustomFormField(
                                focusNode: mobileNode,
                                icon: Icons.phone_android,
                                hintText: ' . . . رقم الموبايل',
                                keyboardtype: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return ' . . . من فضلك ادخل رقم المحمول';
                                  } else if (value.length < 10) {
                                    return ' . . .  من فضلك ادخل رقم محمول صحيح';
                                  }
                                  {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    customerMobile = int.parse(value);
                                  });
                                },
                                onSubmitted: (value) {
                                  customerMobile = int.parse(value);
                                  print(customerMobile);
                                  FocusScope.of(context)
                                      .requestFocus(phoneNode);
                                },
                                onSaved: (value) {
                                  newForm = CustomerForm(
                                    name: newForm.name,
                                    mobile: int.parse(value),
                                    phone: newForm.phone,
                                    address: newForm.address,
                                    callTime: newForm.callTime,
                                    quantity: newForm.quantity,
                                  );
                                },
                              ),
                              CustomFormField(
                                focusNode: phoneNode,
                                icon: Icons.phone,
                                hintText: ' . . . الهاتف الأرضي',
                                keyboardtype: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return ' . . . من فضلك ادخل رقم الهاتف';
                                  } else if (value.length < 9) {
                                    return ' . . .  من فضلك ادخل رقم هاتف صحيح';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    customerPhone = int.parse(value);
                                  });
                                },
                                onSubmitted: (value) {
                                  customerPhone = int.parse(value);
                                  print(customerPhone);
                                  FocusScope.of(context)
                                      .requestFocus(addressNode);
                                },
                                onSaved: (value) {
                                  newForm = CustomerForm(
                                    name: newForm.name,
                                    mobile: newForm.mobile,
                                    phone: int.parse(value),
                                    address: newForm.address,
                                    callTime: newForm.callTime,
                                    quantity: newForm.quantity,
                                  );
                                },
                              ),
                              CustomFormField(
                                focusNode: addressNode,
                                icon: Icons.home,
                                hintText: ' . . . العنوان',
                                keyboardtype: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return ' . . . من فضلك ادخل العنوان';
                                  } else if (value.length < 10) {
                                    return ' . . . من فضلك ادخل عنوان لا يقل عن 20 حرف';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    customerAddress = value;
                                  });
                                },
                                onSubmitted: (value) {
                                  customerAddress = value;
                                  FocusScope.of(context).requestFocus(cityNode);
                                },
                                onSaved: (value) {
                                  newForm = CustomerForm(
                                    name: newForm.name,
                                    mobile: newForm.mobile,
                                    phone: newForm.phone,
                                    address: value,
                                    callTime: newForm.callTime,
                                    quantity: newForm.quantity,
                                  );
                                },
                              ),
                              CustomFormField(
                                focusNode: cityNode,
                                icon: Icons.location_on,
                                hintText: ' . . . مدينة الاقامة',
                                keyboardtype: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return ' . . . من فضلك ادخل المدينة';
                                  } else if (value.length < 3) {
                                    return ' . . . من فضلك ادخل المدينة';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    customerCity = value;
                                  });
                                },
                                onSubmitted: (value) {
                                  customerCity = value;
                                  FocusScope.of(context).requestFocus(timeNode);
                                },
                                onSaved: (value) {
                                  newForm = CustomerForm(
                                    name: newForm.name,
                                    mobile: newForm.mobile,
                                    phone: newForm.phone,
                                    address: value,
                                    callTime: newForm.callTime,
                                    quantity: newForm.quantity,
                                  );
                                },
                              ),
                              CustomFormField(
                                focusNode: timeNode,
                                icon: Icons.access_time,
                                hintText: ' . . . موعد الاتصال المفضل',
                                keyboardtype: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return ' . . . من فضلك ادخل موعد الاتصال المفضل';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    customerTime = value;
                                    print(customerTime);
                                  });
                                },
                                onSubmitted: (value) {
                                  customerTime = value;
                                  FocusScope.of(context)
                                      .requestFocus(quantityNode);
                                },
                                onSaved: (value) {
                                  newForm = CustomerForm(
                                    name: newForm.name,
                                    mobile: newForm.mobile,
                                    phone: newForm.phone,
                                    address: newForm.address,
                                    callTime: value,
                                    quantity: newForm.quantity,
                                  );
                                },
                              ),
                              CustomFormField(
                                focusNode: quantityNode,
                                icon: Icons.filter_list,
                                hintText: ' . . . العدد المطلوب',
                                keyboardtype: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return ' . . . من فضلك ادخل العدد المطلوب';
                                  } else if (value == '0') {
                                    return ' . . . من فضلك أدخل رقم صحيح';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    customerQuantity = int.parse(value);
                                  });
                                },
                                onSubmitted: (value) {
                                  customerQuantity = int.parse(value);
                                },
                                onSaved: (value) {
                                  newForm = CustomerForm(
                                    name: newForm.name,
                                    mobile: newForm.mobile,
                                    phone: newForm.phone,
                                    address: newForm.address,
                                    callTime: newForm.callTime,
                                    quantity: int.parse(value),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              BottomButton(
                onTap: () {
                  setState(() {
                    productId = selectedProductId;
                  });
                  _saveForm();
                },
                icon: Icons.add_shopping_cart,
                buttonText: 'إتمام الطلب',
              )
            ],
          ),
        ),
      ),
    );
  }
}
