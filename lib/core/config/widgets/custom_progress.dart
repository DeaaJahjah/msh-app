import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: orange,
    ));
  }
}
