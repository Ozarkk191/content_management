import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
        child: Center(
          child: Image.asset(
            "assets/icons/icon_app.png",
          ),
          //
        ),
      ),
    );
  }
}
