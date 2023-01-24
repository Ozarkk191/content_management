import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../models/content_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/constant.dart';
import '../../widgets/avatars/main_avatar.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/layouts/main_layout.dart';
import '../home/home_layout.dart';

class CreateContentPage extends StatefulWidget {
  const CreateContentPage({super.key});

  @override
  State<CreateContentPage> createState() => _CreateContentPageState();
}

class _CreateContentPageState extends State<CreateContentPage> {
  TextEditingController contentText = TextEditingController();
  XFile? image;
  bool loading = false;
  UserModel userModel = UserModel();

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<bool> onWillPop() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeLayout(pageIndex: 1),
      ),
    );
    return Future.value(true);
  }

  void onCreateContent() async {
    setState(() => loading = true);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance.ref();
    String? imageUrl;
    String uid = userModel.uid!;
    DateTime now = DateTime.now();
    if (image != null) {
      final imageRef =
          storage.child("$uid/content/${now.millisecondsSinceEpoch}.png");
      await imageRef.putFile(File(image!.path));
      imageUrl = await storage
          .child("$uid/content/${now.millisecondsSinceEpoch}.png")
          .getDownloadURL();
    }
    ContentModel content = ContentModel(
      contentText: contentText.text,
      imageUrl: imageUrl,
      contentID: now.millisecondsSinceEpoch.toString(),
    );

    firestore
        .collection("User")
        .doc(uid)
        .collection("Content")
        .doc("${now.millisecondsSinceEpoch}")
        .set(content.toJson())
        .then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeLayout(pageIndex: 1),
        ),
      );
      setState(() => loading = false);
    });
  }

  @override
  void initState() {
    userModel = Provider.of<UserData>(context, listen: false).user;

    super.initState();
  }

  @override
  void dispose() {
    contentText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: MainLayout(
        loading: loading,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade50,
          title: const Text(
            "Create Content",
            style: TextStyle(
              color: fontColor,
            ),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: onWillPop,
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          actions: [
            Center(
              child: InkWell(
                onTap: contentText.text != "" || image != null
                    ? onCreateContent
                    : null,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: contentText.text != "" || image != null
                        ? primaryColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "POST",
                      style: TextStyle(
                        color: contentText.text != "" || image != null
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainAvatar(imageUrl: userModel.imageUrl, radius: 24),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.fullName ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        MainButton(
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: 25,
                          fontSize: 10,
                          color: fontColor.withOpacity(0.9),
                          borderRadius: 10,
                          title: "เพิ่มรูปภาพ",
                          onTap: pickImage,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: contentText,
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "เพิ่มคำอธิบายเกี่ยวกับสิ่งนี้",
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                image != null
                    ? Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 10,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: Image.file(
                              File(
                                image!.path,
                              ),
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  image = null;
                                });
                              },
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
