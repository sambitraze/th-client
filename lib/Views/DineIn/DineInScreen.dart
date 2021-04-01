import 'dart:convert';

import 'package:client/Services/UserService.dart';
import 'package:client/Services/bookingService.dart';
import 'package:client/Views/DineIn/newDineIn.dart';
import 'package:client/models/User.dart';
import 'package:client/models/booking.dart';
import 'package:flutter/material.dart';

import 'TimeClass.dart';

class DineInScreen extends StatefulWidget {
  @override
  _DineInScreenState createState() => _DineInScreenState();
}

class _DineInScreenState extends State<DineInScreen> {
  TabController _tabController;
  List<Booking> todayBookings = [];
  List<Booking> pastBookings = [];
  bool isLoading = false;
  bool isLoading2 = false;

  int page = 0;
  ScrollController _sc = new ScrollController();
  User curUser;

  @override
  void initState() {
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        getMorePastBooking();
      }
    });
    getTodayData();
    super.initState();
  }

  getMorePastBooking() async {
    setState(() {
      isLoading2 = true;
    });
    List<Booking> tempList = await BookingService.getPastBookingByUserIdCount(
        page,
        15,
        curUser.id,
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    setState(() {
      pastBookings.addAll(tempList);
      page += 15;
      isLoading2 = false;
    });
  }

  getTodayData() async {
    setState(() {
      isLoading = true;
    });
    curUser = await UserService.getUserByPhone();
    todayBookings = await BookingService.getTodayBookingByUserId(curUser.id,
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    pastBookings = await BookingService.getPastBookingByUserIdCount(
        page,
        15,
        curUser.id,
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "Dine In Reservation",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.event_seat_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Current Reservations",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                trailing: MaterialButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NewDineIn()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                height: 1,
                endIndent: 20,
                indent: 20,
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: todayBookings.length == 0
                    ? Container(
                        padding: EdgeInsets.all(24),
                        child:
                            Center(child: Text("No Current Bookings found ! ")),
                      )
                    : ListView.builder(
                        itemCount: todayBookings.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text(
                                      "Do you want to cancel today's reservation of ${timeClassToActual(todayBookings[index].startTimeId)} to ${timeClassToActual(todayBookings[index].endTimeId)} ? "),
                                  actions: [
                                    MaterialButton(onPressed: () {
                                      Navigator.of(context).pop();
                                    },child: Text("No"),),
                                    MaterialButton(onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        todayBookings[index].canceled=true;
                                      });
                                      BookingService.updateBooking(jsonEncode(todayBookings[index].toJson()));
                                      getTodayData();
                                    },child: Text("Yes"),)
                                  ],
                                ),
                              );
                            },
                            tileColor: Colors.grey[100],
                            title: richieText(
                              'Slot: ',
                              "${timeClassToActual(todayBookings[index].startTimeId)} to ${timeClassToActual(todayBookings[index].endTimeId)}",
                            ),
                            trailing: richieText(
                              'Table No: ',
                              todayBookings[index].tableId,
                            ),
                          );
                        }),
              ),
              ListTile(
                leading: Icon(
                  Icons.history,
                  color: Colors.black,
                ),
                title: Text(
                  "Previous Reservations",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                height: 1,
                endIndent: 20,
                indent: 20,
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: pastBookings.length == 0
                    ? Container(
                        padding: EdgeInsets.all(24),
                        child: Center(
                            child: Text("No Previous Bookings found ! ")),
                      )
                    : ListView.builder(
                        controller: _sc,
                        itemCount: pastBookings.length + 1,
                        itemBuilder: (context, index) {
                          return index == pastBookings.length
                              ? Center(
                                  child: isLoading2
                                      ? CircularProgressIndicator()
                                      : Container(),
                                )
                              : ListTile(
                                  tileColor: Colors.grey[100],
                                  title: richieText(
                                    'Slot: ',
                                    "${timeClassToActual(pastBookings[index].startTimeId)} to ${timeClassToActual(pastBookings[index].endTimeId)}",
                                  ),
                                  trailing: richieText(
                                    'Table No: ',
                                    pastBookings[index].tableId,
                                  ));
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  timeClassToActual(String id) {
    TimeClass current =
        timeList.where((element) => element.id == int.parse(id)).first;
    return ("${current.hr} : ${current.min}");
  }

  richieText(title, trail) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange),
        children: <TextSpan>[
          TextSpan(
            text: trail,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

List timeList = [
  TimeClass(id: 1, hr: 11, min: 00),
  TimeClass(id: 2, hr: 11, min: 15),
  TimeClass(id: 3, hr: 11, min: 30),
  TimeClass(id: 4, hr: 11, min: 45),
  TimeClass(id: 5, hr: 12, min: 00),
  TimeClass(id: 6, hr: 12, min: 15),
  TimeClass(id: 7, hr: 12, min: 30),
  TimeClass(id: 8, hr: 12, min: 45),
  TimeClass(id: 9, hr: 13, min: 00),
  TimeClass(id: 10, hr: 13, min: 15),
  TimeClass(id: 11, hr: 13, min: 30),
  TimeClass(id: 12, hr: 13, min: 45),
  TimeClass(id: 13, hr: 14, min: 00),
  TimeClass(id: 14, hr: 14, min: 15),
  TimeClass(id: 15, hr: 14, min: 30),
  TimeClass(id: 16, hr: 14, min: 45),
  TimeClass(id: 17, hr: 15, min: 00),
  TimeClass(id: 18, hr: 15, min: 15),
  TimeClass(id: 19, hr: 15, min: 30),
  TimeClass(id: 20, hr: 15, min: 45),
  TimeClass(id: 21, hr: 16, min: 00),
  TimeClass(id: 22, hr: 16, min: 15),
  TimeClass(id: 23, hr: 16, min: 30),
  TimeClass(id: 24, hr: 16, min: 45),
  TimeClass(id: 25, hr: 17, min: 00),
  TimeClass(id: 26, hr: 17, min: 15),
  TimeClass(id: 27, hr: 17, min: 30),
  TimeClass(id: 28, hr: 17, min: 45),
  TimeClass(id: 29, hr: 18, min: 00),
  TimeClass(id: 30, hr: 18, min: 15),
  TimeClass(id: 31, hr: 18, min: 30),
  TimeClass(id: 32, hr: 18, min: 45),
  TimeClass(id: 33, hr: 19, min: 00),
  TimeClass(id: 34, hr: 19, min: 15),
  TimeClass(id: 35, hr: 19, min: 30),
  TimeClass(id: 36, hr: 19, min: 45),
  TimeClass(id: 37, hr: 20, min: 00),
  TimeClass(id: 38, hr: 20, min: 15),
  TimeClass(id: 39, hr: 20, min: 30),
  TimeClass(id: 40, hr: 20, min: 45),
  TimeClass(id: 41, hr: 21, min: 00),
  TimeClass(id: 42, hr: 21, min: 15),
  TimeClass(id: 43, hr: 21, min: 30),
  TimeClass(id: 44, hr: 21, min: 45),
  TimeClass(id: 45, hr: 22, min: 00),
];
