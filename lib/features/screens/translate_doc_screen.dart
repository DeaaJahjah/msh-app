import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
import 'package:msh_app/core/config/widgets/custom_appbar.dart';
import 'package:msh_app/core/config/widgets/custom_dialog.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/core/config/widgets/drop_down_custom.dart';
import 'package:msh_app/core/config/widgets/elevated_button_custom.dart';
import 'package:msh_app/core/services/file_services.dart';
import 'package:msh_app/features/database/translate_docs_db_service.dart';
import 'package:msh_app/features/models/translate_document.dart';
import 'package:msh_app/features/providers/sata_provider.dart';
import 'package:msh_app/features/providers/translate_docs_provider.dart';
import 'package:msh_app/features/screens/widgets/send_ordar_sheet.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class TransalteDocScreen extends StatefulWidget {
  static const String routeName = '/transalte-docs';

  const TransalteDocScreen({super.key});

  @override
  State<TransalteDocScreen> createState() => _TransalteDocScreenState();
}

class _TransalteDocScreenState extends State<TransalteDocScreen> {
  bool doUhavePassport = false;
  bool isLoading = false;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        context.read<TranslateDocsProvider>().add();
      },
    );
    super.initState();
  }

  @override
  void deactivate() {
    context.read<TranslateDocsProvider>().docs = [];
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            const CustomAppBar(title: 'ترجمة أوراق'),
            Consumer<TranslateDocsProvider>(builder: (context, provider, child) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    final doc = provider.docs[index];
                    return DocCard(
                      document: doc,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => sizedBoxMedium,
                  itemCount: provider.docs.length);
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'هل لديك جواز سفر',
                  style: meduimTextStyle.copyWith(color: orange, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Radio(
                      value: true,
                      groupValue: doUhavePassport,
                      activeColor: orange,
                      onChanged: (value) {
                        setState(() {
                          doUhavePassport = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('نعم'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: false,
                      activeColor: orange,
                      groupValue: doUhavePassport,
                      onChanged: (value) {
                        setState(() {
                          doUhavePassport = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('لا'),
                  ],
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: ElevatedButtonCustom(
                  isLoading: isLoading,
                  text: 'موافق',
                  onPressed: () async {
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

                          final TranslateDocument translateDocument = TranslateDocument(
                            clientId: null,
                            clientName: clientName.text,
                            phone: clientPhone.text,
                            documents: context.read<TranslateDocsProvider>().docs,
                            doYouHavePassport: doUhavePassport,
                          );
                          context.read<StateProvider>().changeState(true);

                          await TranslateDocsDbService().create(doc: translateDocument, context: context);

                          context.read<StateProvider>().changeState(false);
                        },
                      ));
                      return;
                    }

                    if (context.firebaseUser != null) {
                      final TranslateDocument translateDocument = TranslateDocument(
                        clientId: context.firebaseUser!.uid,
                        clientName: context.firebaseUser!.displayName,
                        documents: context.read<TranslateDocsProvider>().docs,
                        doYouHavePassport: doUhavePassport,
                      );

                      setState(() {
                        isLoading = true;
                      });
                      await TranslateDocsDbService().create(doc: translateDocument, context: context);

                      setState(() {
                        isLoading = false;
                      });
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class DocCard extends StatefulWidget {
  const DocCard({
    super.key,
    required this.index,
    required this.document,
  });
  final int index;
  final Document document;
  @override
  State<DocCard> createState() => _DocCardState();
}

class _DocCardState extends State<DocCard> {
  XFile? pickedimage;
  String fileName = '';
  File? imageFile;
  Future<String?> _pickImage() async {
    final picker = ImagePicker();
    try {
      pickedimage = await picker.pickImage(source: ImageSource.gallery);
      fileName = path.basename(pickedimage!.path);
      imageFile = File(pickedimage!.path);
      setState(() {});
      if (imageFile != null) {
        return await FileDbService().uploadeimage(fileName, imageFile!, context);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xff0E4888),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Text(
                      'بيانات الوثيقة',
                      style: meduimTextStyle.copyWith(color: orange, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () async {
                          String? imageUrl = await _pickImage();
                          print(imageUrl);
                          if (imageUrl != null) {
                            context.read<TranslateDocsProvider>().docs[widget.index] =
                                widget.document.copyWith(docUrl: imageUrl);
                          }
                          setState(() {});
                        },
                        child: (pickedimage == null)
                            ? Container(
                                // decoration: BoxDecoration( borderRadius: BorderRadius.circular(10)),
                                // padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Image.asset(
                                  'assets/images/doc_pic.png',
                                  width: 150,
                                  height: 200,
                                ),
                              )
                            : Container(
                                // decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(10),
                                width: 150,
                                height: 200,
                                child: Image.file(imageFile!))),
                  ],
                ),
              ),
              DropDownCustom(
                categories: docsTypes,
                selectedItem: context.watch<TranslateDocsProvider>().docs[widget.index].type,
                onChanged: (type) {
                  setState(() {
                    context.read<TranslateDocsProvider>().docs[widget.index] =
                        context.read<TranslateDocsProvider>().docs[widget.index].copyWith(type: type);
                  });
                },
              ),
              sizedBoxSmall,
              DropDownCustom(
                categories: translateLang,
                selectedItem: context.watch<TranslateDocsProvider>().docs[widget.index].translateLanguage,
                onChanged: (type) {
                  setState(() {
                    context.read<TranslateDocsProvider>().docs[widget.index] =
                        context.read<TranslateDocsProvider>().docs[widget.index].copyWith(translateLanguage: type);
                  });
                },
              ),
              sizedBoxSmall,
              if (context.watch<TranslateDocsProvider>().docs[widget.index].translateLanguage.contains('العربية'))
                const Text(
                  'الرجاء احضار دفتر العائلة',
                  style: TextStyle(color: Colors.red),
                ),
              CheckboxListTile(
                value: context.watch<TranslateDocsProvider>().docs[widget.index].adliyaLegalization,
                title: Text(
                  'تصديق عدلية',
                  style: meduimTextStyle.copyWith(color: orange, fontWeight: FontWeight.bold),
                ),
                activeColor: orange,
                onChanged: (value) {
                  setState(() {
                    context.read<TranslateDocsProvider>().docs[widget.index] =
                        context.read<TranslateDocsProvider>().docs[widget.index].copyWith(adliyaLegalization: value);
                  });
                },
              )
            ],
          ),
        ),
        if (context.watch<TranslateDocsProvider>().docs.length - 1 == widget.index) ...[
          sizedBoxSmall,
          SizedBox(
              width: double.infinity,
              child: ElevatedButtonCustom(
                  color: orange,
                  textColor: white,
                  onPressed: () {
                    context.read<TranslateDocsProvider>().add();
                  },
                  text: 'إضافة وثيقة أخرى لترجمتها'))
        ]
      ],
    );
  }
}
