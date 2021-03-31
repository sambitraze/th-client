import 'dart:convert';
import 'dart:math';

import 'package:client/LandingScreen.dart';
import 'package:client/Services/UserService.dart';
import 'package:client/Services/bookingService.dart';
import 'package:client/Services/tableService.dart';
import 'package:client/models/User.dart';
import 'package:client/models/booking.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'TimeClass.dart';

class NewDineIn extends StatefulWidget {
  @override
  _NewDineInState createState() => _NewDineInState();
}

class _NewDineInState extends State<NewDineIn> with TickerProviderStateMixin {
  TabController _tabController;
  int _index = 0;

  List<Tab> tabList = [];
  User curuser;

  List<List<DropdownMenuItem>> startList = List.generate(
      10,
      (i) => List.generate(
            0,
            (index) => DropdownMenuItem(
              child: Text("${timeList[0].hr} : ${timeList[0].min}"),
              value: timeList[0],
            ),
          ),
      growable: true);
  List<List<DropdownMenuItem>> endList = List.generate(
      10,
      (i) => List.generate(
            0,
            (index) => DropdownMenuItem(
              child: Text("${timeList[0].hr} : ${timeList[0].min}"),
              value: timeList[0],
            ),
          ),
      growable: true);
  List<List<TimeRegion>> tableBookingList = List.generate(
      10, (i) => List.generate(0, (index) => TimeRegion()),
      growable: true);

  TimeClass startTime = timeList[0];
  TimeClass endTime = timeList[0];

  List<Booking> bookings = [];

  bool isLoading = false;
  @override
  void initState() {
    getBooking();
    _tabController =
        TabController(length: 10, vsync: this, initialIndex: _index);
    // TODO: implement initState
    super.initState();
  }

  getBooking() async {
    setState(() {
      isLoading = true;
    });
    curuser = await UserService.getUserByPhone();
    bookings = await BookingService.getTodayBooking(
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    for (int i = 0; i < 10; i++) {
      tableBookingList[i].clear();
      bookings.forEach((element) {
        if (i + 1 == int.parse(element.tableId)) {
          setState(() {
            tableBookingList[i].add(TimeRegion(
                startTime: DateTime(
                    today.year,
                    today.month,
                    today.day,
                    timeClassToActualHr(element.startTimeId),
                    timeClassToActualMin(element.startTimeId),
                    0),
                endTime: DateTime(
                    today.year,
                    today.month,
                    today.day,
                    timeClassToActualHr(element.endTimeId),
                    timeClassToActualMin(element.endTimeId),
                    0),
                enablePointerInteraction: false,
                color: Colors.red.withOpacity(0.5),
                text: 'Table No ${element.tableId} Booked'));
          });
        }
      });
    }
    setState(() {});
    genTabs();
    genDropDown();
  }

  genDropDown() {
    for (int i = 0; i < 10; i++) {
      startList[i].clear();
      endList[i].clear();
      timeList.forEach((element) {
        bookings.length == 0
            ? setState(() {
                startList[i].add(DropdownMenuItem(
                  child: Text("${element.hr} : ${element.min}"),
                  value: element,
                ));
                endList[i].add(DropdownMenuItem(
                  child: Text("${element.hr} : ${element.min}"),
                  value: element,
                ));
              })
            : bookings.forEach((booking) {
                if (element.id > int.parse(booking.startTimeId) &&
                    element.id < int.parse(booking.endTimeId)) {
                } else {
                  setState(() {
                    startList[i].add(DropdownMenuItem(
                      child: Text("${element.hr} : ${element.min}"),
                      value: element,
                    ));
                    endList[i].add(DropdownMenuItem(
                      child: Text("${element.hr} : ${element.min}"),
                      value: element,
                    ));
                  });
                }
              });
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  genTabs() {
    for (int i = 0; i < 10; i++) {
      tabList.add(
        Tab(
          text: "Table ${i + 1}",
        ),
      );
    }
  }

  final DateTime today = DateTime.now();
  timeClassToActualHr(String id) {
    TimeClass current =
        timeList.where((element) => element.id == int.parse(id)).first;
    return current.hr;
  }

  timeClassToActualMin(String id) {
    TimeClass current =
        timeList.where((element) => element.id == int.parse(id)).first;
    return current.min;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Scaffold(
                body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      'Choose Table and Time Slot',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    unselectedLabelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.black,
                    tabs: tabList,
                    onTap: (value) {
                      setState(() {
                        _index = value;
                      });
                      _tabController.animateTo(value,
                          curve: Curves.easeIn,
                          duration: Duration(milliseconds: 500));
                    },
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: <Widget>[
                      calendarWidget(0),
                      calendarWidget(1),
                      calendarWidget(2),
                      calendarWidget(3),
                      calendarWidget(4),
                      calendarWidget(5),
                      calendarWidget(6),
                      calendarWidget(7),
                      calendarWidget(8),
                      calendarWidget(9),
                    ],
                  ),
                ),
              ],
            )),
          );
  }

  calendarWidget(int index) {
    //index
    // special regions, start time list, end time list
    return SfCalendar(
      view: CalendarView.day,
      onTap: (value) {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: Center(
                  child: Text("Reservation for date:\n" +
                      value.date.day.toString() +
                      "-" +
                      value.date.month.toString() +
                      "-" +
                      value.date.year.toString()),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose Reservation\nStart Time: "),
                          DropdownButton(
                            items: startList[index],
                            value: startTime,
                            onChanged: (value) {
                              setState(() {
                                startTime = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose Reservation\nEnd Time: "),
                          DropdownButton(
                            items: endList[index],
                            value: endTime,
                            onChanged: (value) {
                              setState(() {
                                endTime = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        "Book",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.orange,
                      onPressed: () async {
                        print(endTime);
                        print(startTime);
                        bool created = await BookingService.createBooking(
                          jsonEncode(
                            {
                              "date":
                                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                              "startTimeID": startTime.id.toString(),
                              "endTimeID": endTime.id.toString(),
                              "tableId": index,
                              "customer": curuser.id,
                              "canceled": false
                            },
                          ),
                        );
                        if (created) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text("Reservation successfully done!"),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LandingScreen()));
                                  },
                                  child: Text("Ok"),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text("Reservation successfully done!"),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LandingScreen()));
                                  },
                                  child: Text("Ok"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      specialRegions: tableBookingList[index],
      allowViewNavigation: true,
      minDate: today,
      maxDate: today,
      allowedViews: [
        CalendarView.day,
        CalendarView.workWeek,
      ],
      timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 11,
          timeInterval: Duration(minutes: 15),
          endHour: 22,
          timeFormat: 'h:m a',
          nonWorkingDays: <int>[]),
    );
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    regions.add(TimeRegion(
        startTime: DateTime(today.year, today.month, today.day, 13, 0, 0),
        endTime: DateTime(today.year, today.month, today.day, 16, 0, 0),
        enablePointerInteraction: false,
        color: Colors.red.withOpacity(0.5),
        text: 'Booked    Table 1'));
    return regions;
  }
}

List timeList = [
  TimeClass(id: 1, hr: 11, min: 0),
  TimeClass(id: 2, hr: 11, min: 15),
  TimeClass(id: 3, hr: 11, min: 30),
  TimeClass(id: 4, hr: 11, min: 45),
  TimeClass(id: 5, hr: 12, min: 0),
  TimeClass(id: 6, hr: 12, min: 15),
  TimeClass(id: 7, hr: 12, min: 30),
  TimeClass(id: 8, hr: 12, min: 45),
  TimeClass(id: 9, hr: 13, min: 0),
  TimeClass(id: 10, hr: 13, min: 0),
  TimeClass(id: 11, hr: 13, min: 15),
  TimeClass(id: 12, hr: 13, min: 30),
  TimeClass(id: 13, hr: 13, min: 45),
  TimeClass(id: 14, hr: 14, min: 0),
  TimeClass(id: 15, hr: 14, min: 15),
  TimeClass(id: 16, hr: 14, min: 30),
  TimeClass(id: 17, hr: 14, min: 45),
  TimeClass(id: 18, hr: 15, min: 0),
  TimeClass(id: 19, hr: 15, min: 15),
  TimeClass(id: 20, hr: 15, min: 30),
  TimeClass(id: 21, hr: 15, min: 45),
  TimeClass(id: 22, hr: 16, min: 0),
  TimeClass(id: 23, hr: 16, min: 15),
  TimeClass(id: 24, hr: 16, min: 30),
  TimeClass(id: 25, hr: 16, min: 45),
  TimeClass(id: 26, hr: 17, min: 0),
  TimeClass(id: 27, hr: 17, min: 15),
  TimeClass(id: 28, hr: 17, min: 30),
  TimeClass(id: 29, hr: 17, min: 45),
  TimeClass(id: 30, hr: 18, min: 0),
  TimeClass(id: 31, hr: 18, min: 15),
  TimeClass(id: 32, hr: 18, min: 30),
  TimeClass(id: 33, hr: 18, min: 45),
  TimeClass(id: 34, hr: 19, min: 0),
  TimeClass(id: 35, hr: 19, min: 15),
  TimeClass(id: 36, hr: 19, min: 30),
  TimeClass(id: 37, hr: 19, min: 45),
  TimeClass(id: 38, hr: 20, min: 0),
  TimeClass(id: 39, hr: 20, min: 15),
  TimeClass(id: 40, hr: 20, min: 30),
  TimeClass(id: 41, hr: 20, min: 45),
  TimeClass(id: 42, hr: 21, min: 0),
  TimeClass(id: 43, hr: 21, min: 15),
  TimeClass(id: 44, hr: 21, min: 30),
  TimeClass(id: 45, hr: 21, min: 45),
  TimeClass(id: 46, hr: 22, min: 0),
];
