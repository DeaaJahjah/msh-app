import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: orange)),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: orange,
            )),
      ],
    );
  }
}
