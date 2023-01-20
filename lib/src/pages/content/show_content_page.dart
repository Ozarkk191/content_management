import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../models/content_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/constant.dart';
import '../../widgets/cards/content_card.dart';
import '../../widgets/layouts/main_layout.dart';

class ShowContentPage extends StatefulWidget {
  final List<ContentModel> list;
  final int index;
  final UserModel user;
  const ShowContentPage({
    super.key,
    required this.list,
    required this.index,
    required this.user,
  });

  @override
  State<ShowContentPage> createState() => _ShowContentPageState();
}

class _ShowContentPageState extends State<ShowContentPage> {
  ItemScrollController scrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  bool isFirstLoad = true;

  @override
  void initState() {
    itemPositionsListener.itemPositions.addListener(() {
      if (isFirstLoad) {
        scrollController.jumpTo(index: widget.index);
        isFirstLoad = false;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade50,
        title: Column(
          children: [
            Text(
              "${widget.user.fullName}",
              style: const TextStyle(color: fontColor, fontSize: 16),
            ),
            const Text(
              "โพสต์",
              style: TextStyle(
                color: fontColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: fontColor,
          ),
        ),
      ),
      child: ScrollablePositionedList.builder(
        itemScrollController: scrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return ContentCard(
            index: index,
            list: widget.list,
            user: widget.user,
          );
        },
      ),
    );
  }
}
