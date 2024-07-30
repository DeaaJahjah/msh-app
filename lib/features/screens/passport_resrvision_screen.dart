import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
import 'package:msh_app/core/config/widgets/custom_appbar.dart';
import 'package:msh_app/core/config/widgets/custom_dialog.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/core/config/widgets/elevated_button_custom.dart';
import 'package:msh_app/features/database/passport_db_service.dart';
import 'package:msh_app/features/models/passport_reservation.dart';
import 'package:msh_app/features/providers/sata_provider.dart';
import 'package:msh_app/features/screens/widgets/send_ordar_sheet.dart';
import 'package:provider/provider.dart';

class PassportReversationScreen extends StatefulWidget {
  static const String routeName = '/passport';

  const PassportReversationScreen({super.key});

  @override
  State<PassportReversationScreen> createState() => _PassportReversationScreenState();
}

class _PassportReversationScreenState extends State<PassportReversationScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController description = TextEditingController();

  bool isLoading = false;

  List<String> passportTypes = ['عادي', 'فوري', 'مستعجل'];
  late String selectedType;
  @override
  void initState() {
    selectedType = passportTypes.first;
    super.initState();
  }

  @override
  void deactivate() {
    context.read<StateProvider>().isLoading = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final maincontext = context;
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          const CustomAppBar(title: 'حجز جواز سفر'),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'اختر نوع جواز السفر',
              style: meduimTextStyle.copyWith(color: orange, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SelectableButton(
            value: passportTypes[0],
            isSelected: selectedType == passportTypes[0],
            onTap: () {
              setState(() {
                selectedType = passportTypes[0];
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SelectableButton(
            value: passportTypes[1],
            isSelected: selectedType == passportTypes[1],
            onTap: () {
              setState(() {
                selectedType = passportTypes[1];
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SelectableButton(
            value: passportTypes[2],
            isSelected: selectedType == passportTypes[2],
            onTap: () {
              setState(() {
                selectedType = passportTypes[2];
              });
            },
          ),
          const SizedBox(
            height: 20,
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

                      final PassportReservation passportReservation = PassportReservation(
                          clientId: null,
                          clientName: clientName.text,
                          phone: clientPhone.text,
                          passportType: selectedType);
                      context.read<StateProvider>().changeState(true);

                      await PassportDbService().create(passport: passportReservation, context: maincontext);

                      context.read<StateProvider>().changeState(false);
                    },
                  ));
                  return;
                }

                if (context.firebaseUser != null) {
                  final PassportReservation passportReservation = PassportReservation(
                      clientId: context.firebaseUser!.uid,
                      clientName: context.firebaseUser!.displayName,
                      passportType: selectedType);

                  setState(() {
                    isLoading = true;
                  });
                  await PassportDbService().create(passport: passportReservation, context: maincontext);

                  setState(() {
                    isLoading = false;
                  });
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

class SelectableButton extends StatelessWidget {
  const SelectableButton({
    super.key,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  final String value;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: isSelected ? orange : background, border: Border.all(color: orange)),
        child: Text(
          value,
          style: meduimTextStyle.copyWith(color: isSelected ? background : orange, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
