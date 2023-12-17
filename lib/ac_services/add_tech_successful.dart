import 'package:flutter/material.dart';
import 'package:takyeef/pages/home_page.dart';
import 'package:takyeef/widgets/bottom_button.dart';

class TechAddingSuccessful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'تمت الإضافة بنجاح',
                softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'سوف يتم الاتصال بك من مقدمي الخدمة خلال ساعات ليتم التأكيد على البيانات و الاضافة',
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
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
                buttonText: 'العودة الى الرئيسية',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
