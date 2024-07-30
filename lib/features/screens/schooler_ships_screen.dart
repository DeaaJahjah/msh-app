import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
import 'package:msh_app/core/config/widgets/custom_appbar.dart';
import 'package:msh_app/core/config/widgets/custom_progress.dart';
import 'package:msh_app/core/config/widgets/elevated_button_custom.dart';
import 'package:msh_app/features/database/schooler_ships_db_service%20copy.dart';
import 'package:msh_app/features/models/scholarship.dart';
import 'package:msh_app/features/screens/add_schoolership_screen.dart';
import 'package:msh_app/features/screens/schooler_ships_details_sccren.dart';

class SchoolerShipsScreen extends StatefulWidget {
  static const String routeName = '/schooler-shpies';

  const SchoolerShipsScreen({super.key});

  @override
  State<SchoolerShipsScreen> createState() => _SchoolerShipsScreenState();
}

class _SchoolerShipsScreenState extends State<SchoolerShipsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          const CustomAppBar(title: 'المنح الجامعية'),
          const SizedBox(height: 20),
          FutureBuilder<List<Scholarship>>(
            future: SchoolerShipsDbService().getAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CustomProgress(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('حدث خطأ'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = snapshot.data!;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    color: white,
                    child: Column(
                      children: [
                        Align(
                          child: Column(
                            children: [
                              Text(
                                data[index].title,
                                style: largTextStyle.copyWith(color: orange),
                              ),
                              Container(
                                height: 3,
                                width: 40,
                                color: orange,
                              ),
                              const SizedBox(height: 10),
                              Image.network(
                                data[index].imageUrl,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                data[index].description,
                                maxLines: 4,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: background),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ElevatedButtonCustom(
                                      text: 'تفاصيل',
                                      color: orange,
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ScholerShipDetailsScreen(
                                            scholarship: data[index],
                                          ),
                                        ));
                                      },
                                    ),
                                  ),
                                  if (context.firebaseUser != null) ...[
                                    GestureDetector(
                                      onTap: () async {
                                        await Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => AddSchoolerShip(
                                            scholarship: data[index],
                                          ),
                                        ));

                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(border: Border.all(color: orange)),
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                        child: const Icon(
                                          Icons.edit,
                                          color: orange,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await SchoolerShipsDbService().delete(id: data[index].id!, context: context);
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(border: Border.all(color: orange)),
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                        child: const Icon(
                                          Icons.delete,
                                          color: orange,
                                        ),
                                      ),
                                    )
                                  ]
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      )),
      floatingActionButton: context.firebaseUser == null
          ? const SizedBox.shrink()
          : FloatingActionButton(
              backgroundColor: white,
              child: const Icon(
                Icons.add,
                color: background,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AddSchoolerShip.routeName);
              }),
    );
  }
}
