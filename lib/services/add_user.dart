import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(String name, String contactNumber, String address, String course,
    String yearLevel, String email, String id) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc(id);

  final json = {
    'name': name,
    'email': email,
    'contactNumber': contactNumber,
    'address': address,
    'course': course,
    'yearLevel': yearLevel,
    'id': docUser.id,
    'profilePicture': 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    'status': 'Active',
  };

  await docUser.set(json);
}
