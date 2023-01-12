import 'package:consultation_system/auth/signup_page.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/repositories/auth_repository.dart';
import 'package:consultation_system/services/navigation.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SignupPage2 extends StatefulWidget {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController middleNameController = TextEditingController();

  TextEditingController surNameController = TextEditingController();

  TextEditingController contactNumberController = TextEditingController();

  SignupPage2(
      {required this.emailController,
      required this.passwordController,
      required this.firstNameController,
      required this.middleNameController,
      required this.surNameController,
      required this.contactNumberController});

  @override
  State<SignupPage2> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage2> {
  final signupformKey = GlobalKey<FormState>();

  final int _dropdownValue1 = 0;

  late String course = 'IT';

  var _value = false;

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
                                      color: Colors.green[700]!,
                                      width: 7.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: BoldText(
                                        label: '2 of 2',
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
                                label: '   Agreement',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 280,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color(0xffF2F2F2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: NormalText(
                                    label:
                                        'By clicking register, I hereby consent to the collection, use, storage, processing and retention by Bukidnon State University of all personal and academic information I may have provided herein, including all documents that I may hereafter execute or submit in connection with my transaction in the University. I hereby agree that the above-mentioned personal information will be accessed and used by the Admissions personnel and by other university personnel who are involved in the consultation. I understand that in relation to the benefits granted under RA 10931 or the Universal Access to Quality Tertiary Education Act, personal information collected and processed in connection to BukSU consultation process shall be shared to concerned government agencies.',
                                    fontSize: 10,
                                    color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 20),
                              width: 50,
                              child: SwitchListTile(
                                value: _value,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                    height: 18,
                                    color: primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onPressed: (() {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignupPage()));
                                    }),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 5, 15, 5),
                                      child: BoldText(
                                          label: 'BACK',
                                          fontSize: 14,
                                          color: Colors.white),
                                    )),
                                Visibility(
                                  visible: _value,
                                  child: MaterialButton(
                                      height: 18,
                                      color: primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onPressed: (() {
                                        if (signupformKey.currentState!
                                                .validate() &&
                                            widget.emailController.text
                                                .contains('buksu.edu.ph')) {
                                          AuthRepository().userSignUp(
                                              widget.firstNameController.text,
                                              widget.middleNameController.text,
                                              widget.surNameController.text,
                                              widget
                                                  .contactNumberController.text,
                                              widget.emailController.text,
                                              widget.passwordController.text,
                                              '',
                                              course);
                                          Navigation(context).goToLoginPage();
                                        }

                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //     builder: (context) => LoginPage()));
                                      }),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 5),
                                        child: BoldText(
                                            label: 'SUBMIT',
                                            fontSize: 14,
                                            color: Colors.white),
                                      )),
                                )
                              ],
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
