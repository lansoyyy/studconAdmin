import 'package:consultation_system/auth/signup_page2.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:consultation_system/widgets/textform_field_widget.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _middleNameController = TextEditingController();

  final TextEditingController _surNameController = TextEditingController();

  final TextEditingController _contactNumberController =
      TextEditingController();

  final signupformKey = GlobalKey<FormState>();

  int _dropdownValue1 = 0;

  late String course = 'IT';

  final _value = false;

  var status = 'on';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: Stack(
        children: [
          Card(
            child: Center(
              child: Container(
                height: 550,
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[100]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: SingleChildScrollView(
                    child: Form(
                      key: signupformKey,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.green[200]!,
                                      width: 7.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: BoldText(
                                        label: '1 of 2',
                                        fontSize: 15,
                                        color: Colors.black),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: BoldText(
                                  label: 'Account Registration',
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Center(
                              child: NormalText(
                                  label: 'Provide basic account credentials',
                                  fontSize: 10,
                                  color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                NormalText(
                                    label: '───────────────',
                                    fontSize: 8,
                                    color: Colors.black),
                                NormalText(
                                    label: 'BUKIDNON STATE UNIVERSITY',
                                    fontSize: 8,
                                    color: Colors.black),
                                NormalText(
                                    label: '───────────────',
                                    fontSize: 8,
                                    color: Colors.black),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            NormalText(
                                label: 'Email',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            TextformfieldWidget(
                                prefixIcon: const Icon(Icons.email),
                                label: 'Email',
                                textFieldController: _emailController),
                            const SizedBox(
                              height: 5,
                            ),
                            NormalText(
                                label:
                                    'Only institutional email address is allowed.\ne.g example@buksu.edu.ph',
                                fontSize: 9,
                                color: Colors.black),
                            const SizedBox(
                              height: 10,
                            ),
                            NormalText(
                                label: 'Password',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            TextformfieldWidget(
                                prefixIcon: const Icon(Icons.lock),
                                label: 'Password',
                                textFieldController: _passwordController),
                            const SizedBox(
                              height: 5,
                            ),
                            NormalText(
                                label:
                                    '- Your password can’t be too similar to your other personal information.\n- Your password must contain at least 8 characters.\n- Your password can’t be a commonly used password.\n- Your password can’t be entirely numeric.',
                                fontSize: 9,
                                color: Colors.black),
                            const SizedBox(
                              height: 10,
                            ),
                            NormalText(
                                label: 'First name',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            TextformfieldWidget(
                              label: 'First name',
                              textFieldController: _firstNameController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            NormalText(
                                label: 'Middle name',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            TextformfieldWidget(
                              label: 'Middle Name',
                              textFieldController: _middleNameController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            NormalText(
                                label: 'Surname',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            TextformfieldWidget(
                              label: 'Surname',
                              textFieldController: _surNameController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            NormalText(
                                label: 'Contact number',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            TextformfieldWidget(
                              label: 'Contact Number',
                              textFieldController: _contactNumberController,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Department'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                      color: greyColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 2, 20, 2),
                                      child: DropdownButton(
                                        underline: Container(
                                            color: Colors.transparent),
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        value: _dropdownValue1,
                                        items: [
                                          DropdownMenuItem(
                                            onTap: () {
                                              course = "Automotive";
                                            },
                                            value: 0,
                                            child: Center(
                                                child: Row(children: const [
                                              Text("Automotive",
                                                  style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    color: Colors.black,
                                                  ))
                                            ])),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              course = "Food Technology";
                                            },
                                            value: 1,
                                            child: Center(
                                                child: Row(children: const [
                                              Text("Food Technology",
                                                  style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    color: Colors.black,
                                                  ))
                                            ])),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              course = "Electronic Technology";
                                            },
                                            value: 2,
                                            child: Center(
                                                child: Row(children: const [
                                              Text("Electronic Technology",
                                                  style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    color: Colors.black,
                                                  ))
                                            ])),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              course =
                                                  "Entertainment and\nMultimedia Computing";
                                            },
                                            value: 3,
                                            child: Center(
                                                child: Row(children: const [
                                              Text(
                                                  "Entertainment and\nMultimedia Computing",
                                                  style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    color: Colors.black,
                                                  ))
                                            ])),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              course = "Information Technology";
                                            },
                                            value: 4,
                                            child: Center(
                                                child: Row(children: const [
                                              Text("Information Technology",
                                                  style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    color: Colors.black,
                                                  ))
                                            ])),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _dropdownValue1 =
                                                int.parse(value.toString());
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: MaterialButton(
                                  height: 18,
                                  color: primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: (() {
                                    if (signupformKey.currentState!
                                            .validate() &&
                                        _emailController.text
                                            .contains('buksu.edu.ph')) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => SignupPage2(
                                                  emailController:
                                                      _emailController,
                                                  passwordController:
                                                      _passwordController,
                                                  firstNameController:
                                                      _firstNameController,
                                                  middleNameController:
                                                      _middleNameController,
                                                  surNameController:
                                                      _surNameController,
                                                  contactNumberController:
                                                      _contactNumberController)));
                                    }
                                  }),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: BoldText(
                                        label: 'SUBMIT',
                                        fontSize: 14,
                                        color: Colors.white),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
