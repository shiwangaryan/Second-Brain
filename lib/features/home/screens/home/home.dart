import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solution_challenge_app/common/widgets/appbar/appbar.dart'
    as Appbar;
import 'package:solution_challenge_app/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:solution_challenge_app/features/home/screens/home/widgets/image_carousel.dart';
import 'package:solution_challenge_app/features/journal/screens/journal.dart';
import 'package:solution_challenge_app/firebase/gauth.dart';
import 'package:solution_challenge_app/login.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final circleBgColor = const Color.fromARGB(255, 195, 225, 255);

  late String? name = "";
  late String? email = "";
  late String? imageUrl = "";
  DateTime todayDate = DateTime.now();
  List<dynamic> boxKeyData = [];
  List<dynamic> tasks = [];
  int colorSelected = 0;
  var sampleTask = {
    'title': 'Dental Appointment',
    'note': 'meet doctor at dental clinic for seeing the cavity',
    'startTime': '9:11',
    'endTime': '12:00',
    'color': '0xFFF34B3F'
  };
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  List<String> taskColor = [
    '0xFF1E90FF',
    '0xFF1E90FF',
    '0xFFE678FF',
    '0xFFF34B3F'
  ];
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime =
      TimeOfDay(hour: DateTime.now().hour + 1, minute: DateTime.now().minute);
  late String startTimeString;
  late String endTimeString;

  @override
  void initState() {
    super.initState();
    setData();
    startTimeString =
        '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
    endTimeString =
        '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}';
    tasks.add(sampleTask);
  }

  void submitEvent() async {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      var calendarData = {
        'title': titleController.text,
        'note': noteController.text,
        'color': taskColor[colorSelected],
        'startTime': startTimeString,
        'endTime': endTimeString,
      };

      var box = Hive.box('calendar');
      String dayStringKey =
          '${todayDate.day.toString().padLeft(2, '0')}${todayDate.month.toString().padLeft(2, '0')}${todayDate.year}';
      bool containsKey = box.containsKey(dayStringKey);

      if (containsKey) {
        List<dynamic> data = await box.get(dayStringKey);
        data.add(calendarData);
        box.put(dayStringKey, data);
      } else {
        List<dynamic> data = [];
        data.add(calendarData);
        box.put(dayStringKey, data);
      }
      titleController.clear();
      noteController.clear();
      setState(() {
        colorSelected = 0;
        startTime = TimeOfDay.now();
        endTime = TimeOfDay(
            hour: DateTime.now().hour + 1, minute: DateTime.now().minute);
        startTimeString =
            '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
        endTimeString =
            '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}';
        tasks = box.values.toList();
      });
    }
  }

  void addEventDialogue() {
    setState(() {
      startTime = TimeOfDay.now();
      endTime = TimeOfDay(
          hour: DateTime.now().hour + 1, minute: DateTime.now().minute);
      startTimeString =
          '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
      endTimeString =
          '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}';
    });
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color.fromARGB(255, 194, 241, 255),
        scrollable: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                '${todayDate.day}/${todayDate.month}/${todayDate.year}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Center(
                child: Text(
                  'Add Event',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  colorSelected = 0;
                  titleController.clear();
                  noteController.clear();
                  startTime = TimeOfDay.now();
                  endTime = TimeOfDay(
                      hour: DateTime.now().hour + 1,
                      minute: DateTime.now().minute);
                });
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
                size: 24,
              ),
            ),
          ],
        ),
        content: Form(
          child: SizedBox(
            width: 400,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 5),
                  child: DialogueText(text: 'Title'),
                ),
                StringInfoFormField(text: 'Title', controller: titleController),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 5),
                  child: DialogueText(text: 'Note'),
                ),
                StringInfoFormField(
                    text: 'Description', controller: noteController),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 5),
                            child: DialogueText(text: 'Start Time'),
                          ),
                          InkWell(
                            onTap: () async {
                              TimeOfDay? timeSelected = await showTimePicker(
                                context: context,
                                initialTime: startTime,
                                initialEntryMode: TimePickerEntryMode.dial,
                              );
                              if (timeSelected != null) {
                                setState(() {
                                  startTime = timeSelected;
                                  startTimeString =
                                      '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(startTimeString,
                                        style: const TextStyle(
                                            color: Colors.black54)),
                                    const Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 5),
                            child: DialogueText(text: 'End Time'),
                          ),
                          InkWell(
                            onTap: () async {
                              TimeOfDay? timeSelected = await showTimePicker(
                                context: context,
                                initialTime: endTime,
                                initialEntryMode: TimePickerEntryMode.dial,
                              );
                              if (timeSelected != null) {
                                setState(() {
                                  endTime = timeSelected;
                                  endTimeString =
                                      '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}';
                                });
                              }
                            },
                            child: Builder(builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        endTimeString,
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                      const Icon(
                                        Icons.watch_later_outlined,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 8),
                      child: DialogueText(text: 'Color'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Builder(builder: (context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    colorSelected = 3;
                                  });
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF34B3F),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.done,
                                      color: colorSelected == 3
                                          ? Colors.white
                                          : const Color(0xFFF34B3F),
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text('Appointments'),
                            ],
                          );
                        }),
                        Builder(builder: (context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    colorSelected = 2;
                                  });
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE678FF),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.done,
                                      color: colorSelected == 2
                                          ? Colors.white
                                          : const Color(0xFFE678FF),
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text('Daily Routine'),
                            ],
                          );
                        }),
                        Builder(builder: (context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    colorSelected = 1;
                                  });
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E90FF),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.done,
                                      color: colorSelected == 1
                                          ? Colors.white
                                          : const Color(0xFF1E90FF),
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text('Events'),
                            ],
                          );
                        }),
                      ],
                    )
                  ],
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
                  backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
                ),
                onPressed: () {
                  titleController.clear();
                  noteController.clear();
                  FocusScope.of(context).unfocus();
                  setState(() {
                    colorSelected = 0;
                    startTime = TimeOfDay.now();
                    endTime = TimeOfDay(
                        hour: DateTime.now().hour + 1,
                        minute: DateTime.now().minute);
                  });
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
                  backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
                ),
                onPressed: () => {
                  submitEvent(),
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

  int listLength() {
    String key =
        '${todayDate.day.toString().padLeft(2, '0')}${todayDate.month.toString().padLeft(2, '0')}${todayDate.year}';
    var box = Hive.box('calendar');
    setState(() {
      boxKeyData = box.get(key);
    });
    return boxKeyData.length;
  }

  void onSelected(DateTime day, DateTime focusedDay) {
    setState(() {
      todayDate = day;
    });
  }

  Future<void> setData() async {
    final user = await GoogleAuth().getUser();
    setState(() {
      name = user?.displayName;
      email = user?.email;
      imageUrl = user?.photoURL;
    });
  }

  bool noTasks = false;

  @override
  Widget build(BuildContext context) {
    String boxKey =
        '${todayDate.day.toString().padLeft(2, '0')}${todayDate.month.toString().padLeft(2, '0')}${todayDate.year}';
    var hiveBox = Hive.box('calendar');
    bool hasData = hiveBox.containsKey(boxKey);
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              circleBgColor: circleBgColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Appbar.CustomAppBar(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            name ?? 'User',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        GestureDetector(
                          onTap: () async {
                            Get.dialog(AlertDialog(
                              title: const Text('Logout'),
                              content: const Text(
                                  'Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await GoogleAuth().signOut();
                                    var box = Hive.box('user');
                                    box.clear();
                                    Get.offAll(() => const LoginPage());
                                  },
                                  child: const Text('Logout'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ));
                          },
                          child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      imageUrl ??
                                          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ))),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Memories',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 42,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Get.to(const JournalScreen());
                              },
                              icon: const Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Colors.white,
                                size: 36,
                              ))
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0, right: 20, left: 20),
                    child: ImageCarousel(),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: 7,
                  right: 26,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      addEventDialogue();
                    },
                    child: const Text(
                      'Add Event',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Calendar',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 42,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 72),
                      SizedBox(
                        child: TableCalendar(
                          locale: 'en_US',
                          rowHeight: 43,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          ),
                          availableGestures: AvailableGestures.all,
                          selectedDayPredicate: (day) =>
                              isSameDay(day, todayDate),
                          focusedDay: todayDate,
                          firstDay: DateTime.utc(todayDate.year - 10, 1, 1),
                          lastDay: DateTime.utc(todayDate.year + 10, 12, 31),
                          onDaySelected: onSelected,
                          calendarStyle: const CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: Color.fromARGB(255, 118, 192, 252),
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0, top: 24),
                        child: Container(
                          width: 42,
                          height: 3,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5E4E4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Today's Schedule",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            !hasData
                                ? const NoTask()
                                : Transform.translate(
                                    offset: const Offset(0, -20),
                                    child: SizedBox(
                                      height: listLength() * 150 <= 600
                                          ? listLength() * 150
                                          : 600,
                                      child: ListView.builder(
                                        itemCount: listLength(),
                                        itemBuilder: (context, index) {
                                          return ScheduleListTile(
                                              task: boxKeyData[index]);
                                        },
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleListTile extends StatelessWidget {
  const ScheduleListTile({
    super.key,
    required this.task,
  });

  final dynamic task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Color(int.parse(task['color'])),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.watch_later_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${task['startTime']} - ${task['endTime']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  task['note'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoTask extends StatelessWidget {
  const NoTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        SizedBox(
          width: 350,
          height: 350,
          child: SvgPicture.asset('assets/calendar/no_task.svg'),
        ),
        Transform.translate(
          offset: const Offset(0, -26),
          child: const Text(
            "-  No Tasks Yet  -",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

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
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
      ),
    );
  }
}

class DialogueText extends StatelessWidget {
  const DialogueText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
