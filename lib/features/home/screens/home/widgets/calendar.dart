// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/apigeeregistry/v1.dart';
// import 'package:googleapis/calendar/v3.dart' as googleAPI;
// import 'package:googleapis/identitytoolkit/v3.dart';
// import 'package:googleapis/servicemanagement/v1.dart';
// import 'package:solution_challenge_app/utils/logging/firebase_authentication.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:http/http.dart';
// import 'package:http/io_client.dart';

// class CalendarEvents extends StatefulWidget {
//   const CalendarEvents({super.key});

//   @override
//   State<CalendarEvents> createState() => _CalendarEventsState();
// }

// class _CalendarEventsState extends State<CalendarEvents> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     clientId: 'OAuth Client ID',
//     scopes: <String>[
//       googleAPI.CalendarApi.calendarScope,
//     ],
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: Text('Event Calendar'),
//       ),
//       body: Container(
//         child: FutureBuilder(
//           future: getGoogleEventsData(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             return Container(
//                 child: Stack(
//               children: [
//                 Container(
//                   child: SfCalendar(
//                     view: CalendarView.month,
//                     initialDisplayDate: DateTime(2020, 5, 15, 9, 0, 0),
//                     dataSource: GoogleDataSource(events: snapshot.data),
//                     monthViewSettings: MonthViewSettings(
//                         appointmentDisplayMode:
//                             MonthAppointmentDisplayMode.appointment),
//                   ),
//                 ),
//                 snapshot.data != null
//                     ? Container()
//                     : Center(
//                         child: CircularProgressIndicator(),
//                       )
//               ],
//             ));
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     if (_googleSignIn.currentUser != null) {
//       _googleSignIn.disconnect();
//       _googleSignIn.signOut();
//     }

//     super.dispose();
//   }

//   Future<List<googleAPI.Event>> getGoogleEventsData() async {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//     final HttpClientProvider httpClient =
//         Http(await googleUser.authHeaders);
//     final googleAPI.CalendarApi calendarAPI = googleAPI.CalendarApi(httpClient);
//     final googleAPI.Events calEvents = await calendarAPI.events.list(
//       "primary",
//     );
//     final List<googleAPI.Event> appointments = <googleAPI.Event>[];
//     if (calEvents != null && calEvents.items != null) {
//       for (int i = 0; i < calEvents.items.length; i++) {
//         final googleAPI.Event event = calEvents.items[i];
//         if (event.start == null) {
//           continue;
//         }
//         appointments.add(event);
//       }
//     }
//     return appointments;
//   }
// }

// class GoogleDataSource extends CalendarDataSource {
//   GoogleDataSource({required List<googleAPI.Event> events}) {
//     this.appointments = events;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     final googleAPI.Event? event = appointments?[index];
//     if (event != null) {
//       return event.start?.date ??
//           (event.start?.dateTime?.toLocal() ?? DateTime.now());
//     } else {
//       // Handle the case when event is null, for example, return the current time
//       return DateTime.now();
//     }
//   }

//   @override
//   bool isAllDay(int index) {
//     return appointments?[index].start.date != null;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     final googleAPI.Event event = appointments?[index];

//     if (event != null) {
//       if (event.endTimeUnspecified != null && event.endTimeUnspecified!) {
//         // If endTimeUnspecified is true
//         return event.start?.date ??
//             event.start?.dateTime?.toLocal() ??
//             DateTime.now();
//       } else {
//         // If endTimeUnspecified is false or null
//         return event.end?.date != null
//             ? event.end!.date!.add(Duration(days: -1))
//             : event.end?.dateTime?.toLocal() ?? DateTime.now();
//       }
//     }

//     // Default value if event is null
//     return DateTime.now();
//   }

//   @override
//   String getLocation(int index) {
//     return appointments?[index].location;
//   }

//   @override
//   String getNotes(int index) {
//     return appointments?[index].description;
//   }

//   @override
//   String getSubject(int index) {
//     final googleAPI.Event? event = appointments?[index];

//     if (event != null && event.summary != null && event.summary!.isNotEmpty) {
//       return event.summary!;
//     }
//     return 'no title';
//   }

// }
