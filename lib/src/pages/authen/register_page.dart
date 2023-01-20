import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/user_bloc.dart';
import '../../../models/user_model.dart';
import '../../../utils/constant.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/layouts/main_layout.dart';
import '../../widgets/textfields/main_textfield.dart';
import '../home/home_layout.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  bool loading = false;
  bool obscureText = true;
  XFile? image;

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void onSignUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    setState(() => loading = true);
    if (!EmailValidator.validate(email) ||
        email == "" ||
        password == "" ||
        password.length < 6 ||
        confirmPassword == "") {
      if (email == "") {
        emailError = "กรุณากรอก Email";
      }
      if (!EmailValidator.validate(email)) {
        emailError = "รูปแบบ Email ไม่ถูกต้อง";
      }
      if (password == "") {
        passwordError = "กรุณากรอก Password";
      }
      if (password.length < 6) {
        passwordError = "Password ต้องไม่น้อยกว่า 6 ตัวอักษร";
      }
      if (confirmPassword != password) {
        confirmPasswordError = "รหัสผ่านไม่ตรงกัน";
      }
      setState(() => loading = false);
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        final storage = FirebaseStorage.instance.ref();
        String? imageUrl;
        if (image != null) {
          final imageRef = storage.child("${credential.user!.uid}/profile.png");
          await imageRef.putFile(File(image!.path));
          imageUrl = await storage
              .child("${credential.user!.uid}/profile.png")
              .getDownloadURL();
        }

        UserModel user = UserModel(
          email: email,
          firstname: firstname.text == "" ? null : firstname.text,
          laststname: lastname.text == "" ? null : lastname.text,
          fullName: lastname.text == "" && firstname.text == ""
              ? null
              : "${firstname.text} ${lastname.text}",
          imageUrl: imageUrl,
          uid: credential.user!.uid,
        );
        firestore
            .collection("User")
            .doc(credential.user!.uid)
            .set(user.toJson())
            .then((value) {
          context.read<UserCubit>().setUser(user);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeLayout(),
            ),
          );
          setState(() => loading = false);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          passwordError = "The password provided is too weak.";
        } else if (e.code == 'email-already-in-use') {
          emailError = "The account already exists for that email.";
        }
        setState(() => loading = false);
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<bool> onWillPop() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
    return Future.value(true);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: MainLayout(
        loading: loading,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Custom Content",
            style: TextStyle(
              color: fontColor,
              fontWeight: FontWeight.w800,
              fontSize: 26,
            ),
          ),
          leading: InkWell(
            onTap: () => onWillPop(),
            child: const Icon(
              Icons.arrow_back,
              color: primaryColor,
            ),
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: fontColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: pickImage,
                        child: SizedBox(
                          width: 90,
                          height: 90,
                          child: Stack(
                            children: [
                              Center(
                                child: image != null
                                    ? CircleAvatar(
                                        backgroundImage: FileImage(
                                          File(image!.path),
                                        ),
                                        radius: 40,
                                      )
                                    : const CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/icons/ic_mascos.png",
                                        ),
                                        radius: 40,
                                      ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      MainTextField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email",
                        error: emailError,
                        prefix: const Icon(
                          Icons.mail_outline_rounded,
                          color: Colors.grey,
                        ),
                        onChanged: (value) {
                          if (emailError != null) {
                            setState(() {
                              emailError = null;
                            });
                          }
                        },
                      ),
                      MainTextField(
                        controller: firstname,
                        hintText: "Firstname",
                        prefix: const Icon(
                          Icons.person_outline_outlined,
                          color: Colors.grey,
                        ),
                        onChanged: (value) {
                          if (emailError != null) {
                            setState(() {
                              emailError = null;
                            });
                          }
                        },
                      ),
                      MainTextField(
                        controller: lastname,
                        hintText: "Lastname",
                        prefix: const Icon(
                          Icons.person_outline_outlined,
                          color: Colors.grey,
                        ),
                        onChanged: (value) {
                          if (emailError != null) {
                            setState(() {
                              emailError = null;
                            });
                          }
                        },
                      ),
                      MainTextField(
                        controller: password,
                        obscureText: obscureText,
                        hintText: "Password",
                        error: passwordError,
                        prefix: const Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.grey,
                        ),
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: Icon(
                            obscureText
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                        onChanged: (value) {
                          if (passwordError != null) {
                            setState(() {
                              passwordError = null;
                            });
                          }
                        },
                      ),
                      MainTextField(
                        controller: confirmPassword,
                        obscureText: obscureText,
                        hintText: "Confirm Password",
                        error: confirmPasswordError,
                        prefix: const Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.grey,
                        ),
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: Icon(
                            obscureText
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                        onChanged: (value) {
                          if (confirmPasswordError != null) {
                            setState(() {
                              confirmPasswordError = null;
                            });
                          }
                        },
                      ),
                      const Expanded(child: SizedBox()),
                      MainButton(
                        title: "Sing Up",
                        onTap: () => onSignUp(
                          email: email.text,
                          password: password.text,
                          confirmPassword: confirmPassword.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
