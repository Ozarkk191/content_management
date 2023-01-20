import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_bloc.dart';
import '../../../models/content_model.dart';
import '../../../models/user_model.dart';
import '../../widgets/cards/single_card_content.dart';
import '../../widgets/layouts/main_layout.dart';
import 'other_profile_page.dart';

class HomePage extends StatefulWidget {
  final PageController controller;
  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContentModel> contentList = [];

  bool loading = true;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void getAllContent() async {
    firestore.collection("User").get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        getContent(value.docs[i].id.toString());
      }
    });
  }

  void getContent(String id) async {
    final userData = await firestore.collection("User").doc(id).get();
    UserModel user = UserModel.fromJson(userData.data()!);
    firestore
        .collection("User")
        .doc(id)
        .collection("Content")
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        ContentModel content = ContentModel.fromJson(value.docs[i].data());
        content.fullname = user.fullName;
        content.userUrl = user.imageUrl;
        content.uid = user.uid;
        contentList.add(content);
      }
      contentList.shuffle();
      setState(() => loading = false);
    });
  }

  @override
  void initState() {
    getAllContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      loading: loading,
      child: ListView.builder(
        itemCount: contentList.length,
        itemBuilder: (context, index) {
          return SingleCardContent(
            content: contentList[index],
            onTap: () {
              if (contentList[index].uid ==
                  context.read<UserCubit>().state.uid) {
                widget.controller.jumpToPage(1);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OtherProfilePage(uid: contentList[index].uid!),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
