import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/services/navigation.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

PreferredSizeWidget appbarWidget(PageController page) {
  final box = GetStorage();
  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('CONSULTATION-USERS')
      .doc(box.read('id'))
      .snapshots();

  return AppBar(
    actions: [
      const SizedBox(
        width: 20,
      ),
      Center(
          child: BoldText(
              label: 'BukSU Consultation', fontSize: 24, color: primary)),
      const Expanded(child: SizedBox()),
      const CircleAvatar(
        minRadius: 20,
        maxRadius: 20,
        backgroundImage: NetworkImage('assets/images/dean.jpg'),
      ),
      const SizedBox(
        width: 10,
      ),
      Center(
          child: BoldText(label: 'ADMIN', fontSize: 18, color: Colors.black)),
      const SizedBox(
        width: 10,
      ),
      PopupMenuButton(
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: (() async {
                Navigation(context).goToLoginPage();
                Navigation(context).goToLoginPage();
              }),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: NormalText(
                    label: 'Logout', fontSize: 12, color: Colors.black),
              ),
            ),
          ];
        },
      ),
      const SizedBox(
        width: 20,
      ),
    ],
    backgroundColor: Colors.white,
  );
}
