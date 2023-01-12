import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/drop_down_button.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../widgets/appabr_widget.dart';

class PermissionPage extends StatefulWidget {
  PageController page = PageController();

  PermissionPage({required this.page});

  @override
  State<PermissionPage> createState() => _ReportTabState();
}

class _ReportTabState extends State<PermissionPage> {
  int _dropdownValue = 0;

  late String year = 'All';

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
    if (year == 'All') {
      return FirebaseFirestore.instance.collection('Concerns').snapshots();
    } else if (year == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('concern', isEqualTo: year)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('concern', isEqualTo: year)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(widget.page),
      body: Container(
        color: greyAccent,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  NormalText(
                      label: 'Permission List', fontSize: 24, color: primary),
                  const Expanded(child: SizedBox()),
                  const SizedBox(
                    width: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 200),
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
                          style: const TextStyle(color: Colors.white),
                          value: _dropdownValue,
                          items: [
                            DropdownMenuItem(
                              onTap: () {
                                year = 'All';
                              },
                              value: 0,
                              child: DropDownItem(label: 'All'),
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                year = 'Attendance';
                              },
                              value: 1,
                              child: DropDownItem(label: 'Attendance'),
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                year = 'Grades';
                              },
                              value: 2,
                              child: DropDownItem(label: 'Grades'),
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                year = 'Requirements';
                              },
                              value: 3,
                              child: DropDownItem(label: 'Requirements'),
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                year = 'Others';
                              },
                              value: 4,
                              child: DropDownItem(label: 'Others'),
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
                    width: 50,
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
                              DateTime created =
                                  data.docs[index]['dateTime'].toDate();

                              String formattedTime =
                                  DateFormat.yMMMd().add_jm().format(created);
                              return Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3, color: Colors.grey[200]!)),
                                  height: 500,
                                  child: SingleChildScrollView(
                                    child: DataTable(
                                      headingRowColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                              (Set<MaterialState> states) {
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
                                                fontSize: 16,
                                                color: Colors.white)),
                                        DataColumn(
                                            label: BoldText(
                                                label: 'Student Name',
                                                fontSize: 16,
                                                color: Colors.white)),

                                        DataColumn(
                                            label: BoldText(
                                                label: 'Permissions',
                                                fontSize: 16,
                                                color: Colors.white)),
                                        DataColumn(
                                            label: BoldText(
                                                label: 'Date and Time',
                                                fontSize: 16,
                                                color: Colors.white)),
                                        DataColumn(
                                            label: BoldText(
                                                label: '',
                                                fontSize: 16,
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
                                                  return Colors.blueGrey[100];
                                                } else {
                                                  return Colors.grey[200];
                                                }
                                              }),
                                              cells: [
                                                DataCell(
                                                  NormalText(
                                                      label: i.toString(),
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  NormalText(
                                                      label: data.docs[i]
                                                          ['name'],
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  NormalText(
                                                      label: data.docs[i]
                                                          ['concern'],
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  NormalText(
                                                      label: formattedTime,
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(MaterialButton(
                                                    color: Colors.red,
                                                    onPressed: (() {
                                                      showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: ((context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Delete permission?'),
                                                              content: const Text(
                                                                  'This action cannot be undone.'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false);
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: const Text(
                                                                      'Delete'),
                                                                  onPressed:
                                                                      () async {
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Concerns')
                                                                        .doc(data
                                                                            .docs[i]
                                                                            .id)
                                                                        .delete();

                                                                    if (!mounted) {
                                                                      return;
                                                                    }
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true);
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          }));

                                                      // FirebaseFirestore.instance
                                                      //     .collection('Concerns')
                                                      //     .doc(data.docs[i].id)
                                                      //     .delete();
                                                    }),
                                                    child: NormalText(
                                                        label: 'Delete',
                                                        fontSize: 12,
                                                        color: Colors.white))),
                                              ]),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
