// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/common/widgets/appbar/appbar.dart';

import '../../../../firebase/gauth.dart';

class MedicinePageAppbar extends StatefulWidget implements PreferredSizeWidget {
  const MedicinePageAppbar({Key? key}) : super(key: key);

  @override
  _MedicinePageAppbarState createState() => _MedicinePageAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(95);
}

class _MedicinePageAppbarState extends State<MedicinePageAppbar> {
  late String? imageUrl = "";

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    final user = await GoogleAuth().getUser();
    setState(() {
      imageUrl = user?.photoURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 34.0),
      child: CustomAppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track your',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Medicines',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.w800,
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
                  image: DecorationImage(
                    image: NetworkImage(
                      imageUrl ??
                          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                    ),
                    fit: BoxFit.cover,
                  )))
        ],
      ),
    );
  }
}
