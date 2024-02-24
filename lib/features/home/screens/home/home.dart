import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solution_challenge_app/common/widgets/appbar/appbar.dart';
import 'package:solution_challenge_app/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:solution_challenge_app/features/home/screens/home/widgets/image_carousel.dart';
import 'package:solution_challenge_app/firebase/gauth.dart';
import 'package:solution_challenge_app/login.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:solution_challenge_app/features/home/model/task.dart';

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
  Task sampleTask = Task(
      'Dental Appointment',
      'meet doctor at dental clinic for seeing the cavity',
      const TimeOfDay(hour: 9, minute: 11),
      const TimeOfDay(hour: 12, minute: 0),
      const Color.fromARGB(255, 243, 75, 63));
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    setData();
    tasks.add(sampleTask);
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
                    child: CustomAppBar(
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
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ))
                          ],
                        ),
                      )),
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
                  top: 0,
                  right: 26,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Add Event',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 43),
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
                          // onPageChanged: ((focusedDay) {}),
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
                            noTasks
                                ? const NoTask()
                                : Transform.translate(
                                    offset: const Offset(0, -20),
                                    child: SizedBox(
                                      height: tasks.length * 250,
                                      child: ListView.builder(
                                        itemCount: tasks.length,
                                        itemBuilder: (context, index) {
                                          Task task = tasks[index];
                                          return ScheduleListTile(task: task);
                                        },
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      )
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

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: task.color,
          borderRadius:
              BorderRadius.circular(15),
        ),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 14),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .start,
                crossAxisAlignment:
                    CrossAxisAlignment
                        .center,
                children: [
                  const Icon(
                    Icons
                        .watch_later_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                      width: 4),
                  Text(
                    '${task.startTime.hour}:${task.startTime.minute.toString().padLeft(2, '0')} - ${task.endTime.hour}:${task.endTime.minute.toString().padLeft(2, '0')}',
                    style:
                        const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                task.note,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight:
                      FontWeight.w400,
                ),
              ),
            ],
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
