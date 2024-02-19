import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_app/features/journal/screens/new_journal.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
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
            body: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: SizedBox(
                  width: 385,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 260,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 20,
                    ),
                    scrollDirection: Axis.vertical,
                    // itemCount: medicineCardList.length,
                    itemBuilder: (context, index) {
                      return;
                      // return medicineCardList[index];
                    },
                  ),
                ),
              ),
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
                  Get.to(const NewJournalPage());
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
