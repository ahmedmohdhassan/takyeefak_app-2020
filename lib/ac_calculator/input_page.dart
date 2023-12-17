import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takyeef/ac_calculator/calculator_Field.dart';
import 'package:takyeef/ac_calculator/calculator_page.dart';
import 'package:takyeef/ac_calculator/results_page.dart';
import 'package:takyeef/widgets/my_drawer.dart';

import 'package:takyeef/ac_calculator/calc_bottom_button.dart';

class InputPage extends StatefulWidget {
  static const routeName = 'calc_input';
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final contentNode = FocusNode();
  final climateNode = FocusNode();
  final closingNode = FocusNode();
  final lengthNode = FocusNode();
  final widthNode = FocusNode();
  final heightNode = FocusNode();
  final _form = GlobalKey<FormState>();

  List<String> roomContent = ['فارغة', 'متوسطة', 'ممتلئة'];
  List<String> roomClosing = ['منعدم', 'متوسط', 'محكم'];
  List<String> roomClimate = ['عادي', 'صحراوي'];
  String selectedContent = 'متوسطة';
  String selectedClosing = 'متوسط';
  String selectedClimate = 'عادي';
  num length;
  num width;
  num height;

  DropdownButton getContentButton() {
    List<DropdownMenuItem<String>> contentList = [];
    for (String content in roomContent) {
      var newItem = DropdownMenuItem(
        child: Center(
          child: Text(
            content,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xFF297AAA),
            ),
          ),
        ),
        value: content,
      );
      contentList.add(newItem);
    }
    var newButton = DropdownButton(
        itemHeight: 58.0,
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.lightBlue[900],
        ),
        iconSize: 35.0,
        underline: Divider(
          color: Colors.transparent,
        ),
        focusNode: contentNode,
        value: selectedContent,
        items: contentList,
        onChanged: (value) {
          setState(() {
            selectedContent = value;
            FocusScope.of(context).requestFocus(closingNode);
          });
        });
    return newButton;
  }

  DropdownButton getClosingButton() {
    List<DropdownMenuItem<String>> closingList = [];
    for (String content in roomClosing) {
      var newItem = DropdownMenuItem(
        child: Center(
          child: Text(
            content,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xFF297AAA),
            ),
          ),
        ),
        value: content,
      );
      closingList.add(newItem);
    }
    var newButton = DropdownButton(
        itemHeight: 58.0,
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.lightBlue[900],
        ),
        iconSize: 35.0,
        underline: Divider(
          color: Colors.transparent,
        ),
        focusNode: closingNode,
        value: selectedClosing,
        items: closingList,
        onChanged: (value) {
          setState(() {
            selectedClosing = value;
          });
        });
    return newButton;
  }

  DropdownButton getClimateButton() {
    List<DropdownMenuItem<String>> climateList = [];
    for (String content in roomClimate) {
      var newItem = DropdownMenuItem(
        child: Center(
          child: Text(
            content,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xFF297AAA),
            ),
          ),
        ),
        value: content,
      );
      climateList.add(newItem);
    }
    var newButton = DropdownButton(
        itemHeight: 58.0,
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.lightBlue[900],
        ),
        iconSize: 35.0,
        underline: Divider(
          color: Colors.transparent,
        ),
        focusNode: climateNode,
        value: selectedClimate,
        items: climateList,
        onChanged: (value) {
          setState(() {
            selectedClimate = value;
            FocusScope.of(context).requestFocus(contentNode);
          });
        });
    return newButton;
  }

  @override
  void dispose() {
    lengthNode.dispose();
    widthNode.dispose();
    heightNode.dispose();
    contentNode.dispose();
    closingNode.dispose();
    climateNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final bool isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    } else {
      _form.currentState.save();

      CalculatorBrain calc = CalculatorBrain(
          height: height,
          width: width,
          length: length,
          selectedContent: selectedContent,
          selectedClosing: selectedClosing,
          selectedClimate: selectedClimate);
      Navigator.of(context)
          .pushNamed(ResultsPage.routeName, arguments: calc.horsePower());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Align(
            alignment: Alignment.center,
            child: Text('حساب التكييف المناسب'),
          ),
        ),
        drawer: MyDrawer(),
        body: Form(
          key: _form,
          child: ListView(
            children: [
              CalcFormField(
                  icon: null,
                  hintText: '. . . طول الغرفة',
                  keyboardtype: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: lengthNode,
                  onChanged: (value) {
                    setState(() {
                      length = double.parse(value);
                    });
                  },
                  onSubmitted: (value) {
                    length = double.parse(value);
                    FocusScope.of(context).requestFocus(widthNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'من فضلك أدخل الطول بالارقام';
                    } else {
                      return null;
                    }
                  },
                  onSaved: null),
              CalcFormField(
                  icon: null,
                  hintText: '. . . عرض الغرفة',
                  keyboardtype: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: widthNode,
                  onChanged: (value) {
                    setState(() {
                      width = double.parse(value);
                    });
                  },
                  onSubmitted: (value) {
                    width = double.parse(value);
                    FocusScope.of(context).requestFocus(heightNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'من فضلك أدخل العرض بالارقام';
                    } else {
                      return null;
                    }
                  },
                  onSaved: null),
              CalcFormField(
                  icon: null,
                  hintText: '. . . إرتفاع الغرفة',
                  keyboardtype: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: heightNode,
                  onChanged: (value) {
                    setState(() {
                      height = double.parse(value);
                    });
                  },
                  onSubmitted: (value) {
                    height = double.parse(value);
                    FocusScope.of(context).requestFocus(climateNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'من فضلك أدخل الارتفاع بالارقام';
                    } else {
                      return null;
                    }
                  },
                  onSaved: null),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: getClimateButton()),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'المناخ',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: getContentButton()),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'المحتوى',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: getClosingButton()),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'الاغلاق',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CalBottomButton(
                onTap: () {
                  _saveForm();
                },
                icon: FontAwesomeIcons.calculator,
                buttonText: ' إحسب الآن',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
