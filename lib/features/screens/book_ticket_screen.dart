import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
import 'package:msh_app/core/config/widgets/custom_appbar.dart';
import 'package:msh_app/core/config/widgets/custom_dialog.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/core/config/widgets/elevated_button_custom.dart';
import 'package:msh_app/core/config/widgets/text_field_custome.dart';
import 'package:msh_app/features/database/ticket_db_service.dart';
import 'package:msh_app/features/models/ticket.dart';
import 'package:msh_app/features/providers/sata_provider.dart';
import 'package:msh_app/features/screens/widgets/send_ordar_sheet.dart';
import 'package:provider/provider.dart';

class BookTicketScreen extends StatefulWidget {
  static const String routeName = '/book-ticket';

  const BookTicketScreen({super.key});

  @override
  State<BookTicketScreen> createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen> {
  TextEditingController target = TextEditingController();
  TextEditingController date = TextEditingController();

  bool isLoading = false;

  List<String> passportTypes = ['داخل سوريا', 'خارج سوريا'];
  late String selectedType;
  @override
  void initState() {
    selectedType = passportTypes.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          const CustomAppBar(title: 'حجز سياحة وسفر'),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'حجوزات السفر',
              style: meduimTextStyle.copyWith(color: orange, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableButton(
                value: passportTypes[0],
                isSelected: selectedType == passportTypes[0],
                onTap: () {
                  setState(() {
                    selectedType = passportTypes[0];
                  });
                },
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
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldCustom(text: 'عنوان الوجهة', controller: target, icon: Icons.person),
          const SizedBox(
            height: 20,
          ),
          TextFieldCustom(text: 'موعد الرحلة', controller: date, icon: Icons.person),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: ElevatedButtonCustom(
              isLoading: context.watch<StateProvider>().isLoading,
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
                      context.read<StateProvider>().changeState(true);

                      final Ticket ticket = Ticket(
                          clientId: null,
                          clientName: clientName.text,
                          phone: clientPhone.text,
                          ticketType: selectedType,
                          target: target.text,
                          date: date.text);

                      await TicketDbService().create(ticket: ticket, context: context);

                      context.read<StateProvider>().changeState(false);
                    },
                  ));

                  return;
                }

                setState(() {
                  isLoading = true;
                });
                if (context.firebaseUser != null) {
                  final Ticket ticket = Ticket(
                      clientId: context.firebaseUser!.uid,
                      clientName: context.firebaseUser!.displayName!,
                      ticketType: selectedType,
                      target: target.text,
                      date: date.text);

                  await TicketDbService().create(ticket: ticket, context: context);

                  setState(() {
                    isLoading = false;
                  });
                }
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(color: isSelected ? orange : background, border: Border.all(color: orange)),
        child: Text(
          value,
          style: meduimTextStyle.copyWith(color: isSelected ? background : orange, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
