import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/widgets/elevated_button_custom.dart';
import 'package:msh_app/core/config/widgets/text_field_custome.dart';
import 'package:msh_app/features/providers/sata_provider.dart';
import 'package:provider/provider.dart';

class SendOrdarSheet extends StatelessWidget {
  const SendOrdarSheet({super.key, required this.clientName, required this.phoneNumber, this.onPressed});
  final TextEditingController clientName;
  final TextEditingController phoneNumber;
  final dynamic Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          sizedBoxSmall,
          const Text(
            'ارسال الطلب باسم',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          TextFieldCustom(text: 'الاسم الكامل', controller: clientName, icon: Icons.person),
          const SizedBox(height: 20),
          TextFieldCustom(text: 'رقم الهاتف', controller: phoneNumber, icon: Icons.person),
          const SizedBox(height: 20),
          ElevatedButtonCustom(
              text: 'موافق', isLoading: context.watch<StateProvider>().isLoading, onPressed: onPressed),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
