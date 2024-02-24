import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solution_challenge_app/features/journal/screens/new_journal.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/journal_widget.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<dynamic> journalCards = [];

  @override
  void initState() {
    super.initState();
    openBox();
  }

  void openBox() async {
    var box = await Hive.openBox('journal');
    setState(() {
      journalCards = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0XFF1A84B8),
            Color.fromARGB(255, 53, 192, 199),
          ],
        ),
      ),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      right: 18,
                      left: 18,
                      bottom: 10,
                    ),
                    child: SizedBox(
                      width: 385,
                      child: MasonryGridView.builder(
                        dragStartBehavior: DragStartBehavior.start,
                        reverse: false,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: journalCards.length,
                        itemBuilder: ((context, index) {
                          var content =
                              journalCards[journalCards.length - index - 1];
                          return JournalWidget(content: content);
                        }),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100)
              ],
            ),
          ),
          Positioned(
            bottom: 90,
            right: 26,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(60),
              ),
              child: IconButton(
                onPressed: () {
                  Get.to(NewJournalPage(addToHiveBox: () => openBox()));
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 5, right: 15),
      child: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'add. create. delete.',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Journal',
              style: TextStyle(
                letterSpacing: 0.6,
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/appbar/shiwang_profile_photo.jpg'),
                    fit: BoxFit.cover,
                  )))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
