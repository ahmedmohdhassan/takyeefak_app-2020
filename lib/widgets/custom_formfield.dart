import 'package:flutter/material.dart';

const customBorder = OutlineInputBorder(
  borderSide: BorderSide(
    width: 3,
    color: Colors.black12,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(30),
  ),
);

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    @required this.icon,
    @required this.hintText,
    @required this.keyboardtype,
    @required this.textInputAction,
    @required this.focusNode,
    @required this.onChanged,
    @required this.onSubmitted,
    @required this.validator,
    @required this.onSaved,
  });
  final IconData icon;
  final String hintText;
  final TextInputType keyboardtype;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function onChanged;
  final Function onSubmitted;
  final Function validator;
  final Function onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: validator,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardtype,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Icon(
            icon,
            color: Color(0xFF1A2038),
          ),
          filled: true,
          fillColor: Colors.white10,
          enabledBorder: customBorder,
          focusedBorder: customBorder,
          errorBorder: customBorder,
        ),
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        onSaved: onSaved,
      ),
    );
  }
}
