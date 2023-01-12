import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/repositories/user_repository.dart';
import 'package:consultation_system/services/add_user.dart';
import 'package:consultation_system/widgets/drop_down_button.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../widgets/appabr_widget.dart';
import '../../widgets/textform_field_widget.dart';

class UsersPage extends StatefulWidget {
  PageController page = PageController();

  UsersPage({required this.page});

  @override
  State<UsersPage> createState() => _ReportTabState();
}

class _ReportTabState extends State<UsersPage> {
  int _dropdownValue = 0;

  late String year = 'All';

  int _dropdownValue1 = 0;
  final int _dropdownValue2 = 0;

  late String course = 'All';

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _middleNameController = TextEditingController();

  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  final TextEditingController _contactNumberController =
      TextEditingController();

  final signupformKey = GlobalKey<FormState>();

  final doc = pw.Document();

  var name = [];
  var email = [];
  var courseStud = [];
  var yearLevel = [];
  var concern = [];
  var status = [];

  void _loggedin() async {
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(20),
            child: pw.Column(children: [
              pw.Table(children: [
                pw.TableRow(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Name', style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Email',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Course',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Year Level',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Concern',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Status',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                ])
              ]),
              pw.SizedBox(
                height: 20,
              ),
              for (int i = 0; i < name.length; i++)
                pw.Table(children: [
                  pw.TableRow(children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(name[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(email[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(courseStud[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(yearLevel[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(concern[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(status[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                  ])
                ])
            ]),
          );
        },
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    await Printing.sharePdf(
        bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/reports.pdf');
    await file.writeAsBytes(await doc.save());
  }

  getFilter() {
    if (course == 'All' && year == 'All') {
      return FirebaseFirestore.instance
          .collection('Users')
          .where('status', isEqualTo: 'Active')
          .snapshots();
    } else if (year == 'Instructor' && course == 'All') {
      print('called');
      return FirebaseFirestore.instance
          .collection('CONSULTATION-USERS')
          .where('status', isEqualTo: 'Active')
          .snapshots();
    } else if (year == 'Instructor') {
      print('called');
      return FirebaseFirestore.instance
          .collection('CONSULTATION-USERS')
          .where('status', isEqualTo: 'Active')
          .where('department', isEqualTo: course)
          .snapshots();
    } else if (course == 'All') {
      return FirebaseFirestore.instance
          .collection('Users')
          .where('yearLevel', isEqualTo: year)
          .where('status', isEqualTo: 'Active')
          .snapshots();
    } else if (year == 'All') {
      return FirebaseFirestore.instance
          .collection('Users')
          .where('course', isEqualTo: course)
          .where('status', isEqualTo: 'Active')
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('Users')
          .where('yearLevel', isEqualTo: year)
          .where('course', isEqualTo: course)
          .where('status', isEqualTo: 'Active')
          .snapshots();
    }
  }

  final newDep = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(year);
    print(course);
    return Scaffold(
      appBar: appbarWidget(widget.page),
      body: Container(
        color: greyAccent,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NormalText(
                      label: 'Manage Users', fontSize: 24, color: primary),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: MaterialButton(
                            height: 40,
                            minWidth: 120,
                            color: primary,
                            onPressed: (() {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 0, bottom: 0),
                                        child: Container(
                                          height: 550,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.grey[100]),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 10, 30, 10),
                                            child: SingleChildScrollView(
                                              child: Form(
                                                key: signupformKey,
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          BoldText(
                                                              label:
                                                                  'Registration',
                                                              fontSize: 18,
                                                              color: primary),
                                                          IconButton(
                                                              onPressed: (() {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }),
                                                              icon: const Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ))
                                                        ],
                                                      ),
                                                      NormalText(
                                                          label:
                                                              'Create student account',
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'First Name',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'First name',
                                                        textFieldController:
                                                            _firstNameController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Middle Name',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'Middle Name',
                                                        textFieldController:
                                                            _middleNameController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Surname',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'Surname',
                                                        textFieldController:
                                                            _surNameController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label:
                                                              'Contact Number',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'Contact Number',
                                                        textFieldController:
                                                            _contactNumberController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Address',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'Address',
                                                        textFieldController:
                                                            addressController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Course',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'Course',
                                                        textFieldController:
                                                            courseController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Year Level',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'Year Level',
                                                        textFieldController:
                                                            yearController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Email',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                          isForStudentReg: true,
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.email),
                                                          label: 'Email',
                                                          textFieldController:
                                                              _emailController),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Password',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.lock),
                                                          label: 'Password',
                                                          textFieldController:
                                                              _passwordController),
                                                      const SizedBox(
                                                        height: 50,
                                                      ),
                                                      Center(
                                                        child: MaterialButton(
                                                            minWidth: 300,
                                                            color: primary,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            onPressed:
                                                                (() async {
                                                              if (signupformKey
                                                                      .currentState!
                                                                      .validate() &&
                                                                  _emailController
                                                                      .text
                                                                      .contains(
                                                                          'student.buksu.edu.ph')) {
                                                                // AuthRepository().userSignUp(
                                                                //     _firstNameController
                                                                //         .text,
                                                                //     _middleNameController
                                                                //         .text,
                                                                //     _surNameController
                                                                //         .text,
                                                                //     _contactNumberController
                                                                //         .text,
                                                                //     _emailController
                                                                //         .text,
                                                                //     _passwordController
                                                                //         .text,
                                                                //     '',
                                                                //     course);

                                                                await FirebaseAuth
                                                                    .instance
                                                                    .createUserWithEmailAndPassword(
                                                                        email: _emailController
                                                                            .text
                                                                            .trim(),
                                                                        password: _passwordController
                                                                            .text
                                                                            .trim())
                                                                    .then(
                                                                        (value) async {
                                                                  addUser(
                                                                      '${_firstNameController.text} ${_surNameController.text}',
                                                                      _contactNumberController
                                                                          .text,
                                                                      addressController
                                                                          .text,
                                                                      courseController
                                                                          .text,
                                                                      yearController
                                                                          .text,
                                                                      _emailController
                                                                          .text,
                                                                      value
                                                                          .user!
                                                                          .uid);
                                                                });

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                _firstNameController
                                                                    .clear();
                                                                _middleNameController
                                                                    .clear();
                                                                _surNameController
                                                                    .clear();
                                                                addressController
                                                                    .clear();
                                                                _contactNumberController
                                                                    .clear();
                                                                _emailController
                                                                    .clear();
                                                                _passwordController
                                                                    .clear();
                                                                courseController
                                                                    .clear();
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    duration: Duration(
                                                                        seconds:
                                                                            5),
                                                                    content: Text(
                                                                        'Student Registered Succesfully!'),
                                                                  ),
                                                                );
                                                              }

                                                              // Navigator.of(context).push(MaterialPageRoute(
                                                              //     builder: (context) => LoginPage()));
                                                            }),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: NormalText(
                                                                  label:
                                                                      'Register Student',
                                                                  fontSize: 24,
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                            }),
                            child: NormalText(
                                label: 'Add Student',
                                fontSize: 12,
                                color: Colors.white)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: MaterialButton(
                            height: 40,
                            minWidth: 120,
                            color: primary,
                            onPressed: (() {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 0, bottom: 0),
                                        child: Container(
                                          height: 550,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.grey[100]),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 10, 30, 10),
                                            child: SingleChildScrollView(
                                              child: Form(
                                                key: signupformKey,
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          BoldText(
                                                              label:
                                                                  'Registration',
                                                              fontSize: 18,
                                                              color: primary),
                                                          IconButton(
                                                              onPressed: (() {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }),
                                                              icon: const Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      NormalText(
                                                          label:
                                                              'Create instructor account',
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'First Name',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'First name',
                                                        textFieldController:
                                                            _firstNameController,
                                                      ),
                                                      NormalText(
                                                          label: 'Middle Name',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextformfieldWidget(
                                                        label: 'Middle Name',
                                                        textFieldController:
                                                            _middleNameController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Surname',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'Surname',
                                                        textFieldController:
                                                            _surNameController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label:
                                                              'Contact Number',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'Contact Number',
                                                        textFieldController:
                                                            _contactNumberController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Department',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                        label: 'Department',
                                                        textFieldController:
                                                            courseController,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Email',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                          isForStudentReg:
                                                              false,
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.email),
                                                          label: 'Email',
                                                          textFieldController:
                                                              _emailController),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      NormalText(
                                                          label: 'Password',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                      TextformfieldWidget(
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.lock),
                                                          label: 'Password',
                                                          textFieldController:
                                                              _passwordController),
                                                      const SizedBox(
                                                        height: 50,
                                                      ),
                                                      Center(
                                                        child: MaterialButton(
                                                            minWidth: 300,
                                                            color: primary,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            onPressed:
                                                                (() async {
                                                              if (signupformKey
                                                                      .currentState!
                                                                      .validate() &&
                                                                  _emailController
                                                                      .text
                                                                      .contains(
                                                                          'buksu.edu.ph')) {
                                                                await FirebaseAuth
                                                                    .instance
                                                                    .createUserWithEmailAndPassword(
                                                                        email: _emailController
                                                                            .text
                                                                            .trim(),
                                                                        password: _passwordController
                                                                            .text
                                                                            .trim())
                                                                    .then(
                                                                        (value) async {
                                                                  UserRepository().addUser(
                                                                      _firstNameController
                                                                          .text,
                                                                      _middleNameController
                                                                          .text,
                                                                      _surNameController
                                                                          .text,
                                                                      _contactNumberController
                                                                          .text,
                                                                      _emailController
                                                                          .text,
                                                                      _passwordController
                                                                          .text,
                                                                      value
                                                                          .user!
                                                                          .uid,
                                                                      courseController
                                                                          .text);
                                                                });

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                _firstNameController
                                                                    .clear();
                                                                _middleNameController
                                                                    .clear();
                                                                _surNameController
                                                                    .clear();
                                                                _contactNumberController
                                                                    .clear();
                                                                _emailController
                                                                    .clear();
                                                                _passwordController
                                                                    .clear();
                                                                courseController
                                                                    .clear();
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    duration: Duration(
                                                                        seconds:
                                                                            5),
                                                                    content: Text(
                                                                        'Instructor Registered Succesfully!'),
                                                                  ),
                                                                );

                                                                // Navigator.of(context).push(MaterialPageRoute(
                                                                //     builder: (context) => LoginPage()));
                                                              }
                                                            }),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: NormalText(
                                                                  label:
                                                                      'Register Instructor',
                                                                  fontSize: 24,
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                            }),
                            child: NormalText(
                                label: 'Add Instructor',
                                fontSize: 12,
                                color: Colors.white)),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                            child: DropdownButton(
                              underline: Container(color: Colors.transparent),
                              iconEnabledColor: Colors.black,
                              isExpanded: true,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'QRegular',
                                  fontSize: 12),
                              value: _dropdownValue,
                              items: [
                                DropdownMenuItem(
                                  onTap: () {
                                    year = 'All';
                                  },
                                  value: 0,
                                  child: DropDownItem(label: 'All Year Level'),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    year = 'First Year';
                                  },
                                  value: 1,
                                  child: DropDownItem(label: '1st Year'),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    year = 'Second Year';
                                  },
                                  value: 2,
                                  child: DropDownItem(label: '2nd Year'),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    year = 'Third Year';
                                  },
                                  value: 3,
                                  child: DropDownItem(label: '3rd Year'),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    year = 'Fourth Year';
                                  },
                                  value: 4,
                                  child: DropDownItem(label: '4th Year'),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    year = 'Instructor';
                                  },
                                  value: 5,
                                  child: DropDownItem(label: 'Instructors'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _dropdownValue = int.parse(value.toString());
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                            child: DropdownButton(
                              underline: Container(color: Colors.transparent),
                              iconEnabledColor: Colors.black,
                              isExpanded: true,
                              value: _dropdownValue1,
                              items: [
                                DropdownMenuItem(
                                  onTap: () {
                                    course = "All";
                                  },
                                  value: 0,
                                  child: Center(
                                      child: Row(children: const [
                                    Text("All Courses",
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            color: primary,
                                            fontSize: 12))
                                  ])),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    course = "Automotive";
                                  },
                                  value: 1,
                                  child: Center(
                                      child: Row(children: const [
                                    Text("Automotive",
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            color: primary,
                                            fontSize: 12))
                                  ])),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    course = "Food Technology";
                                  },
                                  value: 2,
                                  child: Center(
                                      child: Row(children: const [
                                    Text("Food Technology",
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            color: primary,
                                            fontSize: 12))
                                  ])),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    course = "Electronic Technology";
                                  },
                                  value: 3,
                                  child: Center(
                                      child: Row(children: const [
                                    Text("Electronic Technology",
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            color: primary,
                                            fontSize: 12))
                                  ])),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    course =
                                        "Entertainment and\nMultimedia Computing";
                                  },
                                  value: 4,
                                  child: Center(
                                      child: Row(children: const [
                                    Text(
                                        "Entertainment and\nMultimedia Computing",
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            color: primary,
                                            fontSize: 12))
                                  ])),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    course = "Information Technology";
                                  },
                                  value: 5,
                                  child: Center(
                                      child: Row(children: const [
                                    Text("Information Technology",
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            color: primary,
                                            fontSize: 12))
                                  ])),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _dropdownValue1 = int.parse(value.toString());
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: getFilter(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(child: Text('Error'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print('waiting');
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        )),
                      );
                    }

                    final data = snapshot.requireData;

                    return Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: year == 'Instructor'
                                    ? Container(
                                        height: 500,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 3,
                                                color: Colors.grey[200]!)),
                                        child: SingleChildScrollView(
                                          child: DataTable(
                                            headingRowColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                        (Set<MaterialState>
                                                            states) {
                                              return Colors.blue[400];
                                              // Use the default value.
                                            }),
                                            border: TableBorder.all(
                                              color: Colors.white,
                                            ),
                                            // datatable widget
                                            columns: [
                                              // column to set the name
                                              DataColumn(
                                                  label: BoldText(
                                                      label: 'ID',
                                                      fontSize: 14,
                                                      color: Colors.white)),
                                              DataColumn(
                                                  label: BoldText(
                                                      label: 'Instructor Name',
                                                      fontSize: 14,
                                                      color: Colors.white)),

                                              DataColumn(
                                                  label: BoldText(
                                                      label: 'Department',
                                                      fontSize: 14,
                                                      color: Colors.white)),

                                              DataColumn(
                                                  label: BoldText(
                                                      label: '',
                                                      fontSize: 14,
                                                      color: Colors.white)),
                                            ],

                                            rows: [
                                              // row to set the values
                                              for (int i = 0;
                                                  i < snapshot.data!.size;
                                                  i++)
                                                DataRow(
                                                    color: MaterialStateProperty
                                                        .resolveWith<Color?>(
                                                            (Set<MaterialState>
                                                                states) {
                                                      if (i.floor().isEven) {
                                                        return Colors
                                                            .blueGrey[100];
                                                      } else {
                                                        return Colors.grey[200];
                                                      }
                                                    }),
                                                    cells: [
                                                      DataCell(
                                                        NormalText(
                                                            label: i.toString(),
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        NormalText(
                                                            label: data.docs[i][
                                                                    'first_name'] +
                                                                ' ' +
                                                                data.docs[i][
                                                                    'sur_name'],
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        NormalText(
                                                            label: data.docs[i]
                                                                ['department'],
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        SizedBox(
                                                          child: Row(
                                                            children: [
                                                              // MaterialButton(
                                                              //     color: Colors.blue,
                                                              //     child: NormalText(
                                                              //         label: 'Update',
                                                              //         fontSize: 12,
                                                              //         color:
                                                              //             Colors.white),
                                                              //     onPressed: (() {})),

                                                              MaterialButton(
                                                                  color: Colors
                                                                      .blue,
                                                                  onPressed:
                                                                      (() {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            ((context) {
                                                                          return Dialog(
                                                                            child:
                                                                                SizedBox(
                                                                              height: 200,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                                                child: SizedBox(
                                                                                  width: 200,
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      NormalText(label: 'New Department', fontSize: 12, color: Colors.black),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      TextformfieldWidget(
                                                                                        label: 'Enter Department',
                                                                                        textFieldController: newDep,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 20,
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: Alignment.bottomRight,
                                                                                        child: MaterialButton(
                                                                                            color: Colors.blue,
                                                                                            onPressed: (() {
                                                                                              FirebaseFirestore.instance.collection('CONSULTATION-USERS').doc(data.docs[i].id).update({
                                                                                                'department': newDep.text,
                                                                                              });
                                                                                              Navigator.pop(context);
                                                                                            }),
                                                                                            child: NormalText(label: 'Update', fontSize: 12, color: Colors.white)),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }));
                                                                    // FirebaseFirestore
                                                                    //     .instance
                                                                    //     .collection(
                                                                    //         'CONSULTATION-USERS')
                                                                    //     .doc(data
                                                                    //         .docs[i]
                                                                    //         .id)
                                                                    //     .update({
                                                                    //   'status':
                                                                    //       'Inactive',
                                                                    // });
                                                                  }),
                                                                  child: NormalText(
                                                                      label:
                                                                          'Update',
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white)),

                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              MaterialButton(
                                                                  color: Colors
                                                                      .red,
                                                                  onPressed:
                                                                      (() async {
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'CONSULTATION-USERS')
                                                                        .doc(data
                                                                            .docs[i]
                                                                            .id)
                                                                        .update({
                                                                      'status':
                                                                          'Inactive',
                                                                    });
                                                                  }),
                                                                  child: NormalText(
                                                                      label:
                                                                          'Delete',
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 500,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 3,
                                                color: Colors.grey[200]!)),
                                        child: SingleChildScrollView(
                                          child: DataTable(
                                            headingRowColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                        (Set<MaterialState>
                                                            states) {
                                              return Colors.blue[400];
                                              // Use the default value.
                                            }),
                                            border: TableBorder.all(
                                              color: Colors.white,
                                            ),
                                            // datatable widget
                                            columns: [
                                              // column to set the name
                                              DataColumn(
                                                  label: BoldText(
                                                      label: 'ID',
                                                      fontSize: 14,
                                                      color: Colors.white)),
                                              DataColumn(
                                                  label: BoldText(
                                                      label: 'Student Name',
                                                      fontSize: 14,
                                                      color: Colors.white)),

                                              DataColumn(
                                                  label: BoldText(
                                                      label: 'Course',
                                                      fontSize: 14,
                                                      color: Colors.white)),
                                              DataColumn(
                                                  label: BoldText(
                                                      label: 'Year Level',
                                                      fontSize: 14,
                                                      color: Colors.white)),

                                              DataColumn(
                                                  label: BoldText(
                                                      label: '',
                                                      fontSize: 14,
                                                      color: Colors.white)),
                                            ],

                                            rows: [
                                              // row to set the values
                                              for (int i = 0;
                                                  i < snapshot.data!.size;
                                                  i++)
                                                DataRow(
                                                    color: MaterialStateProperty
                                                        .resolveWith<Color?>(
                                                            (Set<MaterialState>
                                                                states) {
                                                      if (i.floor().isEven) {
                                                        return Colors
                                                            .blueGrey[100];
                                                      } else {
                                                        return Colors.grey[200];
                                                      }
                                                    }),
                                                    cells: [
                                                      DataCell(
                                                        NormalText(
                                                            label: i.toString(),
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        NormalText(
                                                            label: data.docs[i]
                                                                ['name'],
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        NormalText(
                                                            label: data.docs[i]
                                                                ['course'],
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        NormalText(
                                                            label: data.docs[i]
                                                                ['yearLevel'],
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        SizedBox(
                                                          child: Row(
                                                            children: [
                                                              // MaterialButton(
                                                              //     color: Colors.blue,
                                                              //     child: NormalText(
                                                              //         label: 'Update',
                                                              //         fontSize: 12,
                                                              //         color:
                                                              //             Colors.white),
                                                              //     onPressed: (() {})),
                                                              PopupMenuButton(
                                                                tooltip:
                                                                    'Update User Info',
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .person_add_alt_outlined,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                // child: MaterialButton(
                                                                //     color: Colors.blue,
                                                                //     child: NormalText(
                                                                //         label: 'Update',
                                                                //         fontSize: 12,
                                                                //         color:
                                                                //             Colors.white),
                                                                //     onPressed: (() {
                                                                //       // FirebaseFirestore
                                                                //       //     .instance
                                                                //       //     .collection(
                                                                //       //         'Users')
                                                                //       //     .doc(data
                                                                //       //         .docs[index]
                                                                //       //         .id)
                                                                //       //     .update({
                                                                //       //   'status':
                                                                //       //       'Deleted',
                                                                //       // });
                                                                //     })),
                                                                itemBuilder:
                                                                    (context) {
                                                                  return [
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          (() {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                ((context) {
                                                                              return Dialog(
                                                                                child: SizedBox(
                                                                                  height: 200,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        NormalText(label: 'Choose Course', fontSize: 14, color: Colors.black),
                                                                                        const SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 220,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              MaterialButton(
                                                                                                  color: Colors.blue,
                                                                                                  onPressed: (() {
                                                                                                    FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                                                      'course': 'Automotive',
                                                                                                    });
                                                                                                    Navigator.of(context).pop();
                                                                                                  }),
                                                                                                  child: NormalText(label: 'Automotive', fontSize: 12, color: Colors.white)),
                                                                                              MaterialButton(
                                                                                                  color: Colors.blue,
                                                                                                  onPressed: (() {
                                                                                                    FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                                                      'course': 'Food Technology',
                                                                                                    });
                                                                                                    Navigator.of(context).pop();
                                                                                                  }),
                                                                                                  child: NormalText(label: 'Food Technology', fontSize: 12, color: Colors.white)),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 410,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              MaterialButton(
                                                                                                  color: Colors.blue,
                                                                                                  onPressed: (() {
                                                                                                    FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                                                      'course': 'Electronic Technology',
                                                                                                    });
                                                                                                    Navigator.of(context).pop();
                                                                                                  }),
                                                                                                  child: NormalText(label: 'Electronic Technology', fontSize: 12, color: Colors.white)),
                                                                                              MaterialButton(
                                                                                                  color: Colors.blue,
                                                                                                  onPressed: (() {
                                                                                                    FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                                                      'course': 'Entertainment and Multimedia Computing',
                                                                                                    });
                                                                                                    Navigator.of(context).pop();
                                                                                                  }),
                                                                                                  child: NormalText(label: 'Entertainment and Multimedia Computing', fontSize: 12, color: Colors.white)),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        MaterialButton(
                                                                                            color: Colors.blue,
                                                                                            onPressed: (() {
                                                                                              FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                                                'course': 'Information Technology',
                                                                                              });
                                                                                              Navigator.of(context).pop();
                                                                                            }),
                                                                                            child: NormalText(label: 'Information Technology', fontSize: 12, color: Colors.white)),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }));
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                ((context) {
                                                                              return const Dialog(
                                                                                child: SizedBox(
                                                                                  height: 400,
                                                                                ),
                                                                              );
                                                                            }));
                                                                      }),
                                                                      child:
                                                                          ListTile(
                                                                        title: NormalText(
                                                                            label:
                                                                                'Edit Course',
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          (() async {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                ((context) {
                                                                              return Dialog(
                                                                                child: SizedBox(
                                                                                  height: 400,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        NormalText(label: 'Edit Year Level', fontSize: 12, color: Colors.black),
                                                                                        const SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 180,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              MaterialButton(
                                                                                                  color: Colors.blue,
                                                                                                  onPressed: (() {
                                                                                                    FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                                                      'yearLevel': 'First Year',
                                                                                                    });
                                                                                                    Navigator.of(context).pop();
                                                                                                  }),
                                                                                                  child: NormalText(label: 'First Year', fontSize: 12, color: Colors.white)),
                                                                                              MaterialButton(
                                                                                                  color: Colors.blue,
                                                                                                  onPressed: (() {
                                                                                                    FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                                                      'yearLevel': 'Second Year',
                                                                                                    });
                                                                                                    Navigator.of(context).pop();
                                                                                                  }),
                                                                                                  child: NormalText(label: 'Second Year', fontSize: 12, color: Colors.white)),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 180,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              MaterialButton(
                                                                                                  color: Colors.blue,
                                                                                                  onPressed: (() {
                                                                                                    FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                                                      'yearLevel': 'Third Year',
                                                                                                    });
                                                                                                    Navigator.of(context).pop();
                                                                                                  }),
                                                                                                  child: NormalText(label: 'Third Year', fontSize: 12, color: Colors.white)),
                                                                                              MaterialButton(
                                                                                                  color: Colors.blue,
                                                                                                  onPressed: (() {
                                                                                                    FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                                                      'yearLevel': 'Fourth Year',
                                                                                                    });
                                                                                                    Navigator.of(context).pop();
                                                                                                  }),
                                                                                                  child: NormalText(label: 'Fourth Year', fontSize: 12, color: Colors.white)),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }));
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                ((context) {
                                                                              return const Dialog(
                                                                                child: SizedBox(
                                                                                  height: 400,
                                                                                ),
                                                                              );
                                                                            }));
                                                                      }),
                                                                      child:
                                                                          ListTile(
                                                                        title: NormalText(
                                                                            label:
                                                                                'Edit Year Level',
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ];
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              MaterialButton(
                                                                  color: Colors
                                                                      .red,
                                                                  onPressed:
                                                                      (() {
                                                                    showDialog(
                                                                        barrierDismissible:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            ((context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                const Text('Delete user?'),
                                                                            content:
                                                                                const Text('This action cannot be undone.'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                child: const Text('Cancel'),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop(false);
                                                                                },
                                                                              ),
                                                                              TextButton(
                                                                                child: const Text('Delete'),
                                                                                onPressed: () async {
                                                                                  await FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                                    'status': 'Deleted',
                                                                                  });

                                                                                  if (!mounted) {
                                                                                    return;
                                                                                  }
                                                                                  Navigator.of(context).pop(true);
                                                                                },
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }));
                                                                  }),
                                                                  child: NormalText(
                                                                      label:
                                                                          'Delete',
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                            ],
                                          ),
                                        ),
                                      ),
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
  }
}
