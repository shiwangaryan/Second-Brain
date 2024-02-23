import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.sumbitFunc,
  });

  final void Function() sumbitFunc;

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
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 20),
              child: IconButton(
                onPressed: () => {sumbitFunc(), Get.back()},
                icon: const Icon(
                  Icons.done,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            )
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

  @override
  Size get preferredSize => const Size.fromHeight(67);
}
