import 'package:flutter/material.dart';
import 'package:solution_challenge_app/common/widgets/appbar/appbar.dart';

class MedicinePageAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const MedicinePageAppbar({
    super.key,
  });

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
  Size get preferredSize => const Size.fromHeight(95);
}
