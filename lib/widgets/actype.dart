import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ACType extends StatelessWidget {
  final String type;
  final Function onTap;
  ACType({
    this.type,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Container(
            color: Color(0xFF282F4B),
            height: 40,
            width: 100,
            child: Center(
              child: Text(
                type,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
