import 'package:flutter/material.dart';
import 'package:flutter_scantendance/components/text_field_container.dart';
import 'package:flutter_scantendance/components/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController textController;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    @required this.textController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        cursorColor: kPrimaryColor,
        controller: textController,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
