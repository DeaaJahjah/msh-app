import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msh_app/core/config/widgets/custom_appbar.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/core/config/widgets/elevated_button_custom.dart';
import 'package:msh_app/core/config/widgets/text_field_custome.dart';
import 'package:msh_app/core/services/file_services.dart';
import 'package:msh_app/features/database/schooler_ships_db_service%20copy.dart';
import 'package:msh_app/features/models/scholarship.dart';
import 'package:path/path.dart' as path;

class AddSchoolerShip extends StatefulWidget {
  static const String routeName = '/add-schooler-ship';

  const AddSchoolerShip({super.key, this.scholarship});
  final Scholarship? scholarship;

  @override
  State<AddSchoolerShip> createState() => _AddSchoolerShipState();
}

class _AddSchoolerShipState extends State<AddSchoolerShip> {
  TextEditingController title = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController description = TextEditingController();
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
  void initState() {
    if (widget.scholarship != null) {
      title = TextEditingController(text: widget.scholarship!.title);
      link = TextEditingController(text: widget.scholarship!.link);
      description = TextEditingController(text: widget.scholarship!.description);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          CustomAppBar(title: widget.scholarship != null ? 'تعديل المنحة' : 'اضافة منحة'),
          InkWell(
              onTap: () {
                _pickImage();
                setState(() {});
              },
              child: widget.scholarship != null
                  ? Container(
                      // decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                      width: 150,
                      height: 200,
                      child: Image.network(widget.scholarship!.imageUrl))
                  : (pickedimage == null)
                      ? Container(
                          // decoration: BoxDecoration( borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(
                            'assets/images/schooler_pic.png',
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
          const SizedBox(
            height: 30,
          ),
          TextFieldCustom(text: 'العنوان', controller: title, icon: Icons.person),
          const SizedBox(
            height: 20,
          ),
          TextFieldCustom(text: 'الرابط', controller: link, icon: Icons.person),
          const SizedBox(
            height: 20,
          ),
          TextFieldCustom(text: 'الوصف', controller: description, icon: Icons.person),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: ElevatedButtonCustom(
              isLoading: isLoading,
              text: widget.scholarship != null ? 'حفظ' : 'موافق',
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                String? imageUrl;

                if (imageFile == null && widget.scholarship == null) {
                  showErrorSnackBar(context, 'الرجاء اختيار صورة');
                  return;
                }

                if (imageFile != null) {
                  imageUrl = await FileDbService().uploadeimage(fileName, imageFile!, context);
                }
                Scholarship scholarship = Scholarship(
                    id: widget.scholarship?.id,
                    title: title.text,
                    description: description.text,
                    imageUrl: imageUrl ?? widget.scholarship!.imageUrl,
                    link: link.text);

                if (widget.scholarship == null) {
                  await SchoolerShipsDbService().addSchoolerShip(scholarship: scholarship, context: context);
                } else {
                  await SchoolerShipsDbService().updateSchoolerShip(scholarship: scholarship, context: context);
                }

                setState(() {
                  isLoading = false;
                });
              },
            ),
          )
        ],
      )),
    );
  }
}
