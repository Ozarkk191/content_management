import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/user_bloc.dart';
import '../../../models/content_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/constant.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/cards/content_card.dart';
import '../../widgets/header_type/header_profile.dart';
import '../../widgets/layouts/main_layout.dart';
import '../content/create_content_page.dart';
import '../content/show_content_page.dart';
import '../profile/edit_profile_page.dart';

class HomeProfilePage extends StatefulWidget {
  const HomeProfilePage({super.key});

  @override
  State<HomeProfilePage> createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {
  List<ContentModel> contentList = [];
  bool loading = true;
  int contentType = 0;

  @override
  void initState() {
    getContent(context);
    super.initState();
  }

  Future<void> getContent(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("User")
        .doc(context.read<UserCubit>().state.uid)
        .collection("Content")
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        ContentModel data = ContentModel.fromJson(value.docs[i].data());
        contentList.add(data);
      }
      contentList = contentList.reversed.toList();
      setState(() => loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
      return MainLayout(
        loading: loading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 45),
                HeaderProfile(
                  totalContent: contentList.length,
                  user: user,
                  headerType: user.headerType ?? 0,
                  createPost: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateContentPage(),
                      ),
                    );
                  },
                  editProfile: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfilePage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      contentTypeMenu(
                        index: 0,
                        active: contentType == 0,
                        icon: FontAwesomeIcons.tableCells,
                      ),
                      contentTypeMenu(
                        index: 1,
                        active: contentType == 1,
                        icon: FontAwesomeIcons.list,
                      ),
                      contentTypeMenu(
                        index: 2,
                        active: contentType == 2,
                        icon: FontAwesomeIcons.film,
                      ),
                    ],
                  ),
                ),
                if (contentList.isEmpty) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Image.asset(
                        "assets/icons/ic_no_data.jpg",
                        width: 150,
                      ),
                      const Text("ยังไม่มีเนื้อหา"),
                    ],
                  ),
                ] else if (contentType == 0) ...[
                  gridView(user),
                ] else if (contentType == 1) ...[
                  listView(user),
                ] else if (contentType == 2) ...[
                  cardView(user),
                ]
              ],
            ),
          ),
        ),
      );
    });
  }

  ListView cardView(UserModel user) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contentList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ContentCard(
          index: index,
          list: contentList,
          user: user,
        );
      },
    );
  }

  ListView listView(UserModel user) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contentList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (content) => ShowContentPage(
                  list: contentList,
                  index: index,
                  user: user,
                ),
              ),
            );
          },
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: fontColor,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: contentList[index].imageUrl != null
                      ? Image.network(
                          contentList[index].imageUrl!,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 150,
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey,
                          child: Text(
                            "${contentList[index].contentText}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${contentList[index].contentText}",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  GridView gridView(UserModel user) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0, bottom: 20),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: contentList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (content) => ShowContentPage(
                  list: contentList,
                  index: index,
                  user: user,
                ),
              ),
            );
          },
          child: Container(
            // padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 0.5,
                color: Colors.black,
              ),
            ),
            child: contentList[index].imageUrl != null
                ? Image.network(
                    contentList[index].imageUrl!,
                    fit: BoxFit.cover,
                  )
                : Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      contentList[index].contentText ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Expanded contentTypeMenu(
      {required int index, required bool active, required IconData icon}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            contentType = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Icon(
                icon,
                color: active ? primaryColor : Colors.grey,
                size: 20,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 3,
              color: active ? fontColor : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
