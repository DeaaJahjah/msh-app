import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/widgets/custom_progress.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final bool isLoading;
  const ElevatedButtonCustom(
      {super.key,
      this.textColor = white,
      this.isLoading = false,
      required this.onPressed,
      required this.text,
      this.color = blue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(color),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder())),
          onPressed: onPressed,
          child: !isLoading
              ? Text(
            text,
            style: TextStyle(color: textColor, fontFamily: font, fontWeight: FontWeight.w600, fontSize: 14),
                )
              : const CustomProgress()),
    );
  }
}
