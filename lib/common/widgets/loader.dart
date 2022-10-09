
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.4),
      child: Center(child: CircularProgressIndicator(
        color: AppColors.tabColor,
      ),),
    );
  }
}