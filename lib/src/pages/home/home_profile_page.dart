import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../models/content_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/constant.dart';
import '../../widgets/cards/content_card.dart';
import '../../widgets/header_type/header_custom.dart';
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
  UserModel userModel = UserModel();

  @override
  void initState() {
    userModel = Provider.of<UserData>(context, listen: false).user;
    // log("home p =>>${userModel.toJson()}");
    getContent(context);

    super.initState();
  }

  Future<void> getContent(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("User")
        .doc(userModel.uid)
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
    return MainLayout(
      loading: loading,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateContentPage(),
            ),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(
          FontAwesomeIcons.pencil,
          size: 20,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.all(10),
                child: userModel.headerType == 9999 &&
                        userModel.headerCustom != null
                    ? HeaderCustom(
                        user: userModel,
                        totalPost: contentList.length,
                        onEdit: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                user: userModel,
                              ),
                            ),
                          );
                        },
                      )
                    : HeaderProfile(
                        totalContent: contentList.length,
                        user: userModel,
                        headerType: userModel.headerType ?? 0,
                        editProfile: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                user: userModel,
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 0.5,
                color: Colors.grey.withOpacity(0.5),
              ),
              const SizedBox(height: 5),
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
              Container(
                height: 0.5,
                color: Colors.grey.withOpacity(0.5),
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
                    const Text("?????????????????????????????????????????????"),
                  ],
                ),
              ] else if (contentType == 0) ...[
                gridView(userModel),
              ] else if (contentType == 1) ...[
                listView(userModel),
              ] else if (contentType == 2) ...[
                cardView(userModel),
              ]
            ],
          ),
        ),
      ),
    );
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
