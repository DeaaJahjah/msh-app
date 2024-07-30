import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/widgets/custom_appbar.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/core/config/widgets/elevated_button_custom.dart';
import 'package:msh_app/features/models/scholarship.dart';
import 'package:url_launcher/url_launcher.dart';

class ScholerShipDetailsScreen extends StatelessWidget {
  static const String routeName = '/scholer-details';

  const ScholerShipDetailsScreen({super.key, this.scholarship});
  final Scholarship? scholarship;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          CustomAppBar(title: scholarship!.title),
          const SizedBox(height: 10),
          Image.network(
            scholarship!.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 10),
          Text(
            scholarship!.description,
            textAlign: TextAlign.right,
            style: const TextStyle(color: white),
          ),
          const SizedBox(height: 10),
          ElevatedButtonCustom(
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse(scholarship!.link))) {
                  await launchUrl(Uri.parse(scholarship!.link));
                } else {
                  showErrorSnackBar(context, 'عذراً الرابط غير صالح');
                }
              },
              text: 'قدم الآن')
        ],
      )),
    );
  }
}
