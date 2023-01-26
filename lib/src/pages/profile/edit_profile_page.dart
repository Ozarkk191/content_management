import 'dart:io';
import 'package:ccm/src/pages/profile/profile_type/header_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../models/user_model.dart';
import '../../../utils/constant.dart';
import '../../widgets/avatars/main_avatar.dart';
import '../../widgets/layouts/main_layout.dart';
import '../home/home_layout.dart';
import 'edit_sub_page.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;
  const EditProfilePage({
    super.key,
    required this.user,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isInit = true;
  bool loading = false;

  UserModel userData = UserModel();

  XFile? image;

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void userUpdate(BuildContext context, UserModel user) async {
    setState(() => loading = true);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance.ref();
    if (image != null) {
      final imageRef = storage.child("${user.uid}/profile.png");
      await imageRef.putFile(File(image!.path));
      user.imageUrl =
          await storage.child("${user.uid}/profile.png").getDownloadURL();
    }
    user.fullName = "${user.firstname} ${user.laststname}";
    if (user.headerType != 9999) {
      user.headerCustom = null;
    }
    await firestore
        .collection("User")
        .doc(user.uid)
        .update(user.toMap())
        .then((value) {
      context.read<UserData>().setUser(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeLayout(pageIndex: 1),
        ),
      );
    });
  }

  @override
  void initState() {
    userData = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      loading: loading,
      appBar: appbar(context),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  MainAvatar(
                    imageUrl: userData.imageUrl,
                    file: image != null ? File(image!.path) : null,
                    radius: 30,
                    onTap: pickImage,
                  ),
                  const Text(
                    "แก้ไขรูปภาพ",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
          line(),
          menu(
            title: "ชื่อ",
            value: userData.firstname ?? "เพิ่มชื่อ",
            onTap: () async {
              final name = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditSubPage(
                    title: "ชื่อ",
                    value: userData.firstname ?? "",
                  ),
                ),
              );
              if (name != null) {
                userData.firstname = name;
                setState(() {});
              }
            },
          ),
          menu(
            title: "นามสกุล",
            value: userData.laststname ?? "เพิ่มนามสกุล",
            onTap: () async {
              final laststname = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditSubPage(
                    title: "นามสกุล",
                    value: userData.laststname ?? "",
                  ),
                ),
              );
              if (laststname != null) {
                userData.laststname = laststname;
                setState(() {});
              }
            },
          ),
          menu(
            title: "คำอธิบายตัวตน",
            value: userData.bio ?? "เพิ่มคำอธิบาย",
            underline: false,
            onTap: () async {
              final bio = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditSubPage(
                    title: "คำอธิบายตัวตน",
                    value: userData.bio ?? "",
                  ),
                ),
              );
              if (bio != null) {
                setState(() {
                  userData.bio = bio;
                });
              }
            },
          ),
          line(),
          buttonMenu(
            title: "กำหนดรูปแบบโปรไฟล์",
            total: userData.headerType!,
            onTap: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HeaderType(user: userData),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  InkWell buttonMenu({
    required Function() onTap,
    required String title,
    int total = 0,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 0.7,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  Row(
                    children: [
                      total == 9999
                          ? const Text("รูปแบบกำหนดเอง")
                          : Text("รูปแบบที่ $total"),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
            line(),
          ],
        ),
      ),
    );
  }

  Container line() {
    return Container(
      height: 0.7,
      color: Colors.grey.shade300,
    );
  }

  SizedBox menu({
    required String title,
    required String value,
    bool underline = true,
    required Function() onTap,
  }) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 0.7,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(title),
                ),
                Container(
                  height: 0.7,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 0.7,
                  ),
                  Text(value),
                  line(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade200,
      title: const Text(
        "แก้ไขโปรไฟล์",
        style: TextStyle(
          color: fontColor,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeLayout(pageIndex: 1),
            ),
          );
        },
        child: const Center(
          child: Text(
            "ยกเลิก",
            style: TextStyle(
              color: fontColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () => userUpdate(context, userData),
          child: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Center(
              child: Text(
                "บันทึก",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
