import 'package:ccm/src/pages/authen/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../models/user_model.dart';
import '../../../utils/constant.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/layouts/main_layout.dart';
import '../../widgets/textfields/main_textfield.dart';
import '../home/home_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String? emailError;
  String? passwordError;
  bool loading = false;
  bool obscureText = true;

  void onSignIn(BuildContext context,
      {required String email, required String password}) async {
    FocusScope.of(context).unfocus();
    setState(() => loading = true);
    if (email == "" ||
        !EmailValidator.validate(email) ||
        password == "" ||
        password.length < 6) {
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
      setState(() => loading = false);
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          value.user!.uid;

          FirebaseFirestore firestore = FirebaseFirestore.instance;
          firestore.collection("User").doc(value.user!.uid).get().then((value) {
            UserModel user = UserModel.fromJson(value.data()!);
            context.read<UserData>().setUser(user);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeLayout(),
              ),
            );
            setState(() => loading = false);
          });
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emailError = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          passwordError = 'Wrong password provided for that user.';
        }
        setState(() => loading = false);
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      loading: loading,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Custom Content",
                            style: TextStyle(
                              color: fontColor.withOpacity(0.9),
                              fontWeight: FontWeight.w900,
                              fontSize: 35,
                            ),
                          ),
                          Text(
                            "Sign in",
                            style: TextStyle(
                              color: fontColor.withOpacity(0.9),
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  MainTextField(
                    controller: email,
                    hintText: "Email",
                    error: emailError,
                    keyboardType: TextInputType.emailAddress,
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
                  MainButton(
                    title: "Login",
                    onTap: () => onSignIn(
                      context,
                      email: email.text,
                      password: password.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "or Sign in with",
                      style: TextStyle(
                        color: fontColor.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      signInButton(
                        iconPath: "assets/icons/ic_google.png",
                        title: "Sign in with Google",
                      ),
                      signInButton(
                        iconPath: "assets/icons/ic_apple.png",
                        title: "Sign in with Apple",
                      ),
                      signInButton(
                        iconPath: "assets/icons/ic_fb.png",
                        title: "Sign in with Facebook",
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: " Register",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInButton({
    required String title,
    required String iconPath,
  }) {
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(
          msg: "Coming Soon!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade400,
          textColor: fontColor,
        );
      },
      child: Container(
        height: 45,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 3,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(iconPath),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: fontColor.withOpacity(0.6),
              ),
            ),
            const SizedBox(
              width: 45,
              height: 45,
            )
          ],
        ),
      ),
    );
  }
}
