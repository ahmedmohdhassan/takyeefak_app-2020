import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const KDiscountsStyle = TextStyle(
  color: Color(0xFF1A2038),
  fontWeight: FontWeight.w900,
  fontSize: 20.0,
);

class CalBottomButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String buttonText;
  CalBottomButton({
    @required this.onTap,
    @required this.icon,
    @required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FaIcon(icon),
              SizedBox(
                width: 10,
              ),
              Text(
                buttonText,
                style: KDiscountsStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
