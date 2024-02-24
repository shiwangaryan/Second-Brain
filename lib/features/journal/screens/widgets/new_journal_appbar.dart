import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pair/pair.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    this.submitFunc,
    required this.tick,
    this.content,
    this.journalCards,
  });

  Future<Pair<bool, int>> Function()? submitFunc;
  final bool tick;
  final dynamic content;
  List<dynamic>? journalCards;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(67);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20),
            child: IconButton(
              onPressed: () => Get.back(),
              color: Colors.white,
              icon: const Icon(
                Icons.arrow_back,
              ),
              iconSize: 28,
            ),
          ),
          actions: [
            widget.tick
                ? Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 20),
                    child: IconButton(
                      onPressed: () async {
                        Pair<bool, int> result = await widget.submitFunc!();
                        bool success = result.key;
                        int contentKey = result.value;
                        if (success) {
                          var box = Hive.box('journal');
                          var journalContent = await box.get(contentKey);
                          journalContent['key'] = contentKey;
                          Get.back();
                        }
                      },
                      icon: const Icon(
                        Icons.done,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const SizedBox(),
            // : Padding(
            //     padding: const EdgeInsets.only(right: 10.0, top: 20),
            //     child: IconButton(
            //       onPressed: () async {
            //         var box = Hive.box('journal');
            //         await box.delete(widget.content['key']);
            //         setState(() {
            //           widget.journalCards = box.values.toList();
            //         });
            //         Get.back();
            //       },
            //       icon: const Icon(
            //         Icons.delete_rounded,
            //         size: 28,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Colors.white.withOpacity(0.7),
        ),
      ],
    );
  }
}
