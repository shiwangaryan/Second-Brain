import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineInfo extends StatelessWidget {
  const MedicineInfo({
    super.key,
    required this.name,
    required this.dosage,
    required this.duration,
    this.stock,
    required this.image,
  });

  final String image;
  final String name;
  final String dosage;
  final String duration;
  final int? stock;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 53, 192, 199),
            Color(0XFF1A84B8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const MedicineInfoAppbar(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 38),
              Container(
                width: 370,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16)),
              ),
              Container(
                width: 370,
                child: Column(
                  children: [
                    Text(name),
                    Text(dosage),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicineInfoAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const MedicineInfoAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: const EdgeInsets.only(top: 23),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 23,
            ),
          ),
        ),
        leadingWidth: 25,
        title: const Padding(
          padding: EdgeInsets.only(top: 28.0, left: 0),
          child: Text(
            'Your Medicine',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
