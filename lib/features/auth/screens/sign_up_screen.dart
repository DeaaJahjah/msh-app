import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
import 'package:msh_app/core/config/widgets/custom_appbar.dart';
import 'package:msh_app/core/config/widgets/elevated_button_custom.dart';
import 'package:msh_app/core/config/widgets/text_field_custome.dart';
import 'package:msh_app/features/auth/Services/authentecation_service.dart';
import 'package:msh_app/features/auth/Services/user_service.dart';
import 'package:msh_app/features/auth/models/user_model.dart';
import 'package:msh_app/features/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  XFile? pickedimage;
  String fileName = '';
  File? imageFile;
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Column(children: [
                const CustomAppBar(title: 'تسجيل كزبون دائم'),
                Image.asset(
                  'assets/images/logo.png',
                  height: MediaQuery.sizeOf(context).height * 0.20,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(text: 'الاسم', controller: userName, icon: Icons.person),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(text: 'البريد الالكتروني', controller: email, icon: Icons.email),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(text: 'كلمة المرور', controller: passwordController, icon: Icons.lock),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(text: 'المهنة', controller: job, icon: Icons.lock),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(
                    text: 'رقم الهاتف',
                    controller: phoneController,
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone),
                const SizedBox(
                  height: 24,
                ),
                !isLoading
                    ? ElevatedButtonCustom(
                        color: blue,
                        textColor: white,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            //TODO:: login by firebase

                            setState(() {
                              isLoading = true;
                            });

                            final re = await FlutterFireAuthServices()
                                .signUp(email: email.text, password: passwordController.text, context: context);

                            if (re == null) {
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }

                            context.firebaseUser!.updatePhotoURL('client');
                            context.firebaseUser!.updateDisplayName(userName.text);

                            await UserDbService().creatUser(
                                user: UserModel(
                                    email: email.text,
                                    job: job.text,
                                    name: userName.text,
                                    phoneNumber: phoneController.text),
                                context: context);
                            setState(() {
                              isLoading = false;
                            });
                            if (mounted) {
                              Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                            }
                          } else {
                            var snackBar = const SnackBar(content: Text('جميع الحقول مطلوبة'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        text: 'انشاء',
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                        color: blue,
                      )),
                sizedBoxLarge
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
