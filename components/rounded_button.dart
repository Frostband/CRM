import 'package:flutter/material.dart';

import '../constant.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color, textColor;
  const RoundedButton({
    Key? key, required this.text, required this.onPressed, required this.color, required this.textColor,
  
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          onPressed: onPressed (),
          child: Text(text, style: TextStyle(color: textColor),),
          ),
      ),
    );
  }
}