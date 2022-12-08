import 'package:flutter/material.dart';
import 'package:uas/constant.dart';

import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedInputField({
    Key? key, required this.hintText, required this.icon, required this.onChanged, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(Icons.person, color: kPrimaryColor,),
          border: InputBorder.none,
          ),
      ),
      );
  }
}