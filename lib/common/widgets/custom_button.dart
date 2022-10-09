import 'package:flutter/material.dart';

import '../utils/app_colors.dart';


class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String txt;
  final Size size;
  final Color txtColor;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.txt,
    required this.size,
    required this.txtColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: AppColors.tabColor,
        minimumSize: size,
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: txtColor,
          
        ),
      ),
    );
  }
}
