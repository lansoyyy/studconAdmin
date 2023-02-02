import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/screens/pages/permission_page.dart';
import 'package:consultation_system/screens/pages/users_page.dart';
import 'package:consultation_system/screens/tabs/analytics_tab.dart';
import 'package:consultation_system/screens/tabs/reports_tab.dart';
import 'package:consultation_system/services/add_categ.dart';
import 'package:consultation_system/widgets/textform_field_widget.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';
import '../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getCodes();
  }

  PageController page = PageController();

  final categController = TextEditingController();

  var classCodes = [];

  getCodes() async {
    var collection = FirebaseFirestore.instance.collection('Class Code');

    var querySnapshot = await collection.get();

    setState(() {
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();

        classCodes.add(data['classCode']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 632,
            color: primary,
            child: SideMenu(
              controller: page,
              style: SideMenuStyle(
                  unselectedTitleTextStyle:
                      const TextStyle(color: Colors.white),

                  // showTooltip: false,
                  displayMode: SideMenuDisplayMode.auto,
                  hoverColor: blueAccent,
                  selectedColor: Colors.black38,
                  selectedTitleTextStyle:
                      GoogleFonts.openSans(color: Colors.white),
                  selectedIconColor: Colors.white,
                  unselectedIconColor: Colors.white
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(10)),
                  // ),
                  // backgroundColor: Colors.blueGrey[700]
                  ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Container(
                  decoration: const BoxDecoration(
                    color: primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Image.asset(
                        'assets/images/bsu.png',
                        height: 120,
                      ),
                    ),
                  ),
                ),
              ),
              items: [
                SideMenuItem(
                  priority: 0,
                  title: 'Permission',
                  onTap: () {
                    page.jumpToPage(0);
                  },
                  icon: const Icon(Icons.info),
                ),
                SideMenuItem(
                  priority: 1,
                  title: 'User Management',
                  onTap: () {
                    page.jumpToPage(1);
                  },
                  icon: const Icon(Icons.home),
                ),
                SideMenuItem(
                  priority: 2,
                  title: 'Reports',
                  onTap: () {
                    page.jumpToPage(2);
                  },
                  icon: const Icon(Icons.report_problem_rounded),
                ),
                SideMenuItem(
                  priority: 3,
                  title: 'Analytics',
                  onTap: () {
                    page.jumpToPage(3);
                  },
                  icon: const Icon(Icons.analytics),
                ),
                SideMenuItem(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return Dialog(
                            child: SizedBox(
                              height: 400,
                              width: 400,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: MaterialButton(
                                            color: Colors.green,
                                            onPressed: (() {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) {
                                                    return Dialog(
                                                      child: SizedBox(
                                                        height: 250,
                                                        width: 300,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10,
                                                                  10,
                                                                  10,
                                                                  10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              NormalText(
                                                                  label:
                                                                      'Name of Category',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              TextformfieldWidget(
                                                                  textFieldController:
                                                                      categController,
                                                                  label: ''),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child:
                                                                    MaterialButton(
                                                                        color: Colors
                                                                            .green,
                                                                        onPressed:
                                                                            (() {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          addCateg(
                                                                              categController.text);

                                                                          categController
                                                                              .clear();
                                                                        }),
                                                                        child: NormalText(
                                                                            label:
                                                                                'Continue',
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.white)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }));
                                            }),
                                            child: NormalText(
                                                label: 'Add Category',
                                                fontSize: 12,
                                                color: Colors.white)),
                                      ),
                                    ),
                                    StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('Categ')
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            print(snapshot.error);
                                            return const Center(
                                                child: Text('Error'));
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            print('waiting');
                                            return const Padding(
                                              padding: EdgeInsets.only(top: 50),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: Colors.black,
                                              )),
                                            );
                                          }

                                          final data = snapshot.requireData;
                                          return Expanded(
                                            child: SizedBox(
                                              child: ListView.builder(
                                                  itemCount:
                                                      snapshot.data?.size ?? 0,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    List subList =
                                                        data.docs[index]['sub'];

                                                    return ExpansionTile(
                                                      title: NormalText(
                                                          label:
                                                              data.docs[index]
                                                                  ['name'],
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      leading: SizedBox(
                                                        width: 100,
                                                        child: Row(
                                                          children: [
                                                            IconButton(
                                                              onPressed: (() {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        ((context) {
                                                                      return Dialog(
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              250,
                                                                          width:
                                                                              300,
                                                                          child:
                                                                              Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                10,
                                                                                10,
                                                                                10,
                                                                                10),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                NormalText(label: 'Name of Subcategory', fontSize: 14, color: Colors.black),
                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                TextformfieldWidget(textFieldController: categController, label: ''),
                                                                                const SizedBox(
                                                                                  height: 20,
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.bottomRight,
                                                                                  child: MaterialButton(
                                                                                      color: Colors.green,
                                                                                      onPressed: (() {
                                                                                        Navigator.of(context).pop();
                                                                                        FirebaseFirestore.instance.collection('Categ').doc(data.docs[index].id).update({
                                                                                          'sub': FieldValue.arrayUnion([
                                                                                            categController.text
                                                                                          ])
                                                                                        });

                                                                                        categController.clear();
                                                                                      }),
                                                                                      child: NormalText(label: 'Continue', fontSize: 12, color: Colors.white)),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }));
                                                              }),
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                            IconButton(
                                                              onPressed: (() {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        ((context) {
                                                                      return AlertDialog(
                                                                        title: NormalText(
                                                                            label:
                                                                                'Are you sure you want to delete this category?',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.black),
                                                                        content: NormalText(
                                                                            label:
                                                                                'This action cannot be undone',
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.grey),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: (() {
                                                                                Navigator.pop(context);
                                                                              }),
                                                                              child: BoldText(label: 'Close', fontSize: 12, color: Colors.black)),
                                                                          TextButton(
                                                                              onPressed: (() {
                                                                                Navigator.pop(context);
                                                                                FirebaseFirestore.instance.collection('Categ').doc(data.docs[index].id).delete();
                                                                              }),
                                                                              child: BoldText(label: 'Continue', fontSize: 14, color: Colors.red)),
                                                                        ],
                                                                      );
                                                                    }));
                                                              }),
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      children: [
                                                        for (int i = 0;
                                                            i < subList.length;
                                                            i++)
                                                          SizedBox(
                                                              height: 150,
                                                              child: ListTile(
                                                                tileColor:
                                                                    Colors
                                                                        .white,
                                                                title: NormalText(
                                                                    label:
                                                                        subList[
                                                                            i],
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                                trailing:
                                                                    IconButton(
                                                                  onPressed:
                                                                      (() {
                                                                    print(data.docs[
                                                                            index]
                                                                        [
                                                                        'sub'][i]);
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Categ')
                                                                        .doc(data
                                                                            .docs[index]
                                                                            .id)
                                                                        .update({
                                                                      'sub': FieldValue
                                                                          .arrayRemove([
                                                                        subList[
                                                                            i]
                                                                      ])
                                                                    });
                                                                  }),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ))
                                                      ],
                                                    );
                                                  })),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
                  },
                  priority: 6,
                  title: 'Categories',
                  icon: const Icon(Icons.category_outlined),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                PermissionPage(page: page),
                UsersPage(page: page),
                ReportTab(
                  page: page,
                ),
                AnalyticsTab(
                  page: page,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
