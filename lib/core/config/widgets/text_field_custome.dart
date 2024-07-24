import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';

class TextFieldCustom extends StatelessWidget {
  int? maxLine = 1;
  final String text;
  final TextEditingController controller;
  final IconData? icon;
  TextInputType? keyboardType;
  void Function(String)? onChanged;
  TextFieldCustom(
      {super.key,
      required this.text,
      required this.controller,
      this.icon,
      this.keyboardType = TextInputType.text,
      this.maxLine,
      this.onChanged});

  get darkGray => null;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: orange,
          height: 49,
          width: 8,
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: blue,
            height: 49,
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: gray, fontFamily: font, fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            maxLines: maxLine,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: background,
              fontFamily: font,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            enableSuggestions: true,
            decoration: InputDecoration(
                fillColor: white,
                filled: true,
                // hintStyle: const TextStyle(color: gray, fontFamily: font, fontSize: 16, fontWeight: FontWeight.normal),
                suffixIcon: Icon(
                  icon,
                  color: blue,
                ),
                isDense: true,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,

                // enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: blue)),
                // focusedBorder: const OutlineInputBorder(
                //   borderSide: BorderSide(color: blue),
                // ),
                // labelText: text,

                iconColor: background,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                errorStyle: const TextStyle(height: 0),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: blue, width: 1),
                ),
                hintStyle:
                    const TextStyle(color: background, fontFamily: font, fontSize: 14, fontWeight: FontWeight.normal),
                labelStyle:
                    const TextStyle(color: background, fontFamily: font, fontSize: 14, fontWeight: FontWeight.normal)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
