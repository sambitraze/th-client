import 'package:client/Services/UserService.dart';
import 'package:client/Services/bookingService.dart';
import 'package:client/Views/DineIn/newDineIn.dart';
import 'package:client/models/User.dart';
import 'package:client/models/booking.dart';
import 'package:flutter/material.dart';

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
                          return Container(
                            child: Text(todayBookings[index].toString()),
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
                              : Container(
                            child: Text(pastBookings[index].toString()),
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
