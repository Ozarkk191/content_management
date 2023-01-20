import 'package:ccm/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../../../bloc/user_bloc.dart';
import '../../../models/user_model.dart';
import '../authen/login_page.dart';
import '../home/home_layout.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () => checkUser(context));

    super.initState();
  }

  void checkUser(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        UserModel user = UserModel.fromJson(value.data()!);

        context.read<UserCubit>().setUser(user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeLayout(),
          ),
        );
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image.asset(
              "assets/icons/ic_bg_content.gif",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  GlowText(
                    "Custom Content",
                    textAlign: TextAlign.center,
                    glowColor: Colors.amber,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: "bufally",
                      fontSize: 40,
                    ),
                  ),
                  GlowText(
                    "Management",
                    textAlign: TextAlign.center,
                    glowColor: Colors.amber,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: "bufally",
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
