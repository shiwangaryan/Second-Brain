import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:solution_challenge_app/features/medicine/screen/widget/medicine_card_class.dart';
import 'package:solution_challenge_app/features/medicine/screen/widget/medicine_appbar.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  TextEditingController medicineName = TextEditingController();
  TextEditingController medicineDosage = TextEditingController();
  TextEditingController medicineDuration = TextEditingController();
  bool imageSelected = false;

  List<dynamic> medicineCardList = [];
  String imageFile = '';

  Future<void> getMedicines() async {
    var box = Hive.box('medicines');
    setState(() {
      medicineCardList = box.values.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getMedicines();
  }

  /// This method is used to add a new medicine card to the Hive box.
  ///
  /// It first checks if the text fields for medicine name, dosage, and duration are not empty.
  /// If they are not empty, it creates a map with the medicine data where the name is capitalized.
  /// Then, it opens the Hive box named 'medicines' and adds the medicine data to it.
  /// After the data is added, it logs a message and clears the text fields.
  /// Finally, it calls `setState` to rebuild the widget with the updated medicines.
  void addMedicineCard() async {
    if (medicineName.text != '' &&
        medicineDosage.text != '' &&
        medicineDuration.text != '') {
      var medicineData = {
        'name':
            "${medicineName.text[0].toUpperCase()}${medicineName.text.substring(1)}",
        'dosage': medicineDosage.text,
        'duration': medicineDuration.text,
        'imageFile': imageFile,
      };
      var box = Hive.box('medicines');
      await box.add(medicineData);
      medicineName.clear();
      medicineDosage.clear();
      medicineDuration.clear();

      setState(() {
        getMedicines();
      });
    }
  }

  void addMedicineDialogue() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF040404),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child:
                    Text('Add Medicine', style: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 1),
              child: IconButton(
                onPressed: () {
                  medicineName.clear();
                  medicineDosage.clear();
                  medicineDuration.clear();
                  imageSelected = false;
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            )
          ],
        ),
        content: Form(
          child: SizedBox(
            width: 280,
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StringInfoFormField(
                    text: 'Medicine name', controller: medicineName),
                const SizedBox(height: 8),
                StringInfoFormField(
                    text: 'Dosage eg: 2pm, 8pm', controller: medicineDosage),
                const SizedBox(height: 8),
                StringInfoFormField(
                    text: 'Duration eg: 4 months',
                    controller: medicineDuration),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => pickImagefromGallery(),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 175,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Text(
                            "Add Medicine's Photo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Builder(builder: (context) {
                        return imageSelected
                            ? const Icon(
                                Icons.done,
                                color: Colors.green,
                                size: 16,
                              )
                            : const SizedBox();
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                ),
                onPressed: () {
                  medicineName.clear();
                  medicineDosage.clear();
                  medicineDuration.clear();
                  imageSelected = false;
                  FocusScope.of(context).unfocus();
                },
                child: const SizedBox(
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                ),
                onPressed: () => {
                  addMedicineCard(),
                  Navigator.pop(context),
                },
                child: const SizedBox(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  pickImagefromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = File(
            '${directory.path}/journal/images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        final imageBytes = await pickedImage.readAsBytes();
        await imagePath.writeAsBytes(imageBytes);

        setState(() {
          imageFile = imagePath.path;
          imageSelected = true;
        });
      } else {
        print('no image selected');
      }
    } catch (e) {
      print('error occured: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //main return of the build function
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0XFF55d0ff),
            Color(0XFF0080bf),
          ],
        ),
      ),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const MedicinePageAppbar(),
            body: Column(
              children: [
                const SizedBox(height: 36),
                const Center(
                  child: Text(
                    'Ongoing Medication',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
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
                        itemCount: medicineCardList.length,
                        itemBuilder: (context, index) {
                          var medicine = medicineCardList[index];
                          return MedicineCard(
                            name: medicine['name'],
                            dosage: medicine['dosage'],
                            duration: medicine['duration'],
                            img: medicine['imageFile'],
                            // () {
                            //   setState(() {
                            //     medicineCardList.removeAt(index);
                            //   });
                            // },
                          );
                        },
                      ),
                    ),
                  ),
                ),
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
                  addMedicineDialogue();
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

//
// other widgets
class StringInfoFormField extends StatelessWidget {
  const StringInfoFormField({
    super.key,
    required this.text,
    required this.controller,
  });

  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(fontSize: 13, color: Colors.black54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.95),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
      ),
    );
  }
}

class IntegerInfoFormField extends StatelessWidget {
  const IntegerInfoFormField({
    super.key,
    required this.text,
    required this.controller,
  });

  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(fontSize: 13, color: Colors.black54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.95),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
      ),
    );
  }
}
