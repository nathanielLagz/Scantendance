import 'package:flutter/material.dart';
import 'package:flutter_scantendance/components/text_field_container.dart';
import 'package:flutter_scantendance/components/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController textController;
  final text;
  const RoundedPasswordField({Key key, this.textController, this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RoundedPasswordFieldState();
}

class RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool passVisible;
  @override
  void initState() {
    super.initState();
    this.passVisible = true;
  }
  
  void toggle() => setState(
    () => passVisible = !passVisible);


  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: passVisible,
        cursorColor: kPrimaryColor,
        controller: widget.textController,
        decoration: InputDecoration(
          hintText: widget.text,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              passVisible? Icons.visibility_off : Icons.visibility,
              color: kPrimaryColor,
            ),
            onPressed: toggle
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}


