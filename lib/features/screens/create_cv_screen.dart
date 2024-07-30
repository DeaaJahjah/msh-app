import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
import 'package:msh_app/core/config/widgets/custom_appbar.dart';
import 'package:msh_app/core/config/widgets/custom_dialog.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/core/config/widgets/elevated_button_custom.dart';
import 'package:msh_app/core/config/widgets/text_field_custome.dart';
import 'package:msh_app/core/services/file_services.dart';
import 'package:msh_app/features/database/cv_db_service.dart';
import 'package:msh_app/features/models/cv_model.dart';
import 'package:msh_app/features/providers/sata_provider.dart';
import 'package:msh_app/features/screens/widgets/send_ordar_sheet.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class CreateCvScreen extends StatefulWidget {
  static const String routeName = '/cv-screen';

  const CreateCvScreen({super.key});

  @override
  State<CreateCvScreen> createState() => _CreateCvScreenState();
}

class _CreateCvScreenState extends State<CreateCvScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController aboutU = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController uCerti = TextEditingController();
  TextEditingController otherCerti = TextEditingController();
  TextEditingController softSkils = TextEditingController();
  TextEditingController personalSkils = TextEditingController();
  TextEditingController languges = TextEditingController();

  XFile? pickedimage;
  String fileName = '';
  File? imageFile;
  bool isLoading = false;
  _pickImage() async {
    final picker = ImagePicker();
    try {
      pickedimage = await picker.pickImage(source: ImageSource.gallery);
      fileName = path.basename(pickedimage!.path);
      imageFile = File(pickedimage!.path);

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            const CustomAppBar(title: 'انشاء سيرة ذاتية'),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: () {
                    _pickImage();
                    setState(() {});
                  },
                  child: (pickedimage == null)
                      ? Container(
                          // decoration: BoxDecoration( borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(
                            'assets/images/cv_pic.png',
                            width: 150,
                            height: 200,
                          ),
                        )
                      : Container(
                          // decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(20),
                          width: 150,
                          height: 200,
                          child: Image.file(imageFile!))),
            ),
            TextFieldCustom(text: 'الاسم الكامل', controller: name, icon: Icons.person),
            const SizedBox(
              height: 20,
            ),
            TextFieldCustom(text: 'المهنة', controller: job, icon: Icons.person),
            const SizedBox(
              height: 20,
            ),
            TextFieldCustom(text: 'وصف عنك', controller: aboutU, icon: Icons.person),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'معلومات الاتصال',
              style: TextStyle(fontWeight: FontWeight.bold, color: orange, fontSize: 16),
            ),
            sizedBoxSmall,
            TextFieldCustom(
              text: 'رقم الهاتف',
              controller: phone,
              icon: Icons.person,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldCustom(
                text: 'الايميل', controller: email, icon: Icons.person, keyboardType: TextInputType.emailAddress),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'الشهادات',
              style: TextStyle(fontWeight: FontWeight.bold, color: orange, fontSize: 16),
            ),
            sizedBoxSmall,
            TextFieldCustom(text: 'الشهادة الجامعية', controller: uCerti, icon: Icons.person),
            const SizedBox(
              height: 20,
            ),
            TextFieldCustom(text: 'شهادات أخرى', controller: otherCerti, icon: Icons.person),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'المهارات',
              style: TextStyle(fontWeight: FontWeight.bold, color: orange, fontSize: 16),
            ),
            sizedBoxSmall,
            TextFieldCustom(text: 'الناعمة', controller: softSkils, icon: Icons.person),
            const SizedBox(
              height: 20,
            ),
            TextFieldCustom(text: 'شخصية', controller: personalSkils, icon: Icons.person),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'اللغات',
              style: TextStyle(fontWeight: FontWeight.bold, color: orange, fontSize: 16),
            ),
            sizedBoxSmall,
            TextFieldCustom(text: 'اللغات', controller: languges, icon: Icons.person),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: ElevatedButtonCustom(
                text: 'موافق',
                isLoading: isLoading,
                onPressed: () async {
                  // setState(() {
                  //   isLoading = true;
                  // });
                  TextEditingController clientName = TextEditingController();
                  TextEditingController clientPhone = TextEditingController();

                  if (context.firebaseUser == null) {
                    await CustomDialogs(context).showbottomSheetDialog(
                        widget: SendOrdarSheet(
                      clientName: clientName,
                      phoneNumber: clientPhone,
                      onPressed: () async {
                        if (clientName.text.isEmpty || clientPhone.text.isEmpty) {
                          showErrorSnackBar(context, 'الرجاء ادخال الاسم ورقم الهاتف');
                          return;
                        }

                        String? imageUrl;
                        context.read<StateProvider>().changeState(true);
                        if (imageFile != null) {
                          imageUrl = await FileDbService().uploadeimage(fileName, imageFile!, context);
                        }
                        final CVModel cvModel = CVModel(
                            clientId: null,
                            clientName: clientName.text,
                            clientPhone: clientPhone.text,
                            phone: job.text,
                            imageUrl: imageUrl,
                            fullName: name.text,
                            aboutYou: aboutU.text,
                            email: email.text,
                            job: job.text,
                            certificates: uCerti.text.split('-') + otherCerti.text.split('-'),
                            skills: personalSkils.text.split('-'),
                            softSkills: softSkils.text.split('-'),
                            languages: languges.text.split('-'));

                        await CvDbService().creatCv(cv: cvModel, context: context);

                        context.read<StateProvider>().changeState(false);
                      },
                    ));
                    return;
                  }

                  setState(() {
                    isLoading = true;
                  });
                  if (context.firebaseUser != null) {
                    String? imageUrl;

                    if (imageFile != null) {
                      imageUrl = await FileDbService().uploadeimage(fileName, imageFile!, context);
                    }
                    final CVModel cvModel = CVModel(
                        clientId: context.firebaseUser?.uid,
                        clientName: context.firebaseUser?.displayName,
                        phone: job.text,
                        imageUrl: imageUrl,
                        fullName: name.text,
                        aboutYou: aboutU.text,
                        email: email.text,
                        job: job.text,
                        certificates: uCerti.text.split('-') + otherCerti.text.split('-'),
                        skills: personalSkils.text.split('-'),
                        softSkills: softSkils.text.split('-'),
                        languages: languges.text.split('-'));

                    await CvDbService().creatCv(cv: cvModel, context: context);

                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
