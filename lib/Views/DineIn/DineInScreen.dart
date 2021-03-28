import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DineInScreen extends StatefulWidget {
  @override
  _DineInScreenState createState() => _DineInScreenState();
}

class _DineInScreenState extends State<DineInScreen> {
  List current = [];
  List completed = [];
  DateTime selectedDate;

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
                  onPressed: () async{
                    DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), // Refer step 1
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null && picked != selectedDate)
                      setState(() {
                        selectedDate = picked;
                      });
                    print(selectedDate.toString());
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
                child: ListView.builder(
                    itemCount: current.length == 0 ? 1 : current.length,
                    itemBuilder: (context, index) {
                      return current.length == 0
                          ? Container(
                              padding: EdgeInsets.all(24),
                              child: Center(
                                  child: Text("No Current Bookings found ! ")),
                            )
                          : Container(
                              child: Text("Booking x1"),
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
                child: ListView.builder(
                    itemCount: current.length == 0 ? 1 : current.length,
                    itemBuilder: (context, index) {
                      return current.length == 0
                          ? Container(
                              padding: EdgeInsets.all(24),
                              child: Center(
                                  child: Text("No Previous Bookings found ! ")),
                            )
                          : Container(
                              child: Text("Booking x2"),
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
