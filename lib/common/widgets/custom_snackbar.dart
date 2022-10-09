import 'package:flutter/material.dart';

void showSnackBar ({
  required BuildContext context,
  Color color = Colors.red,
    required String content
}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: color,
      ),
  );
}