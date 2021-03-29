import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class NewDineIn extends StatefulWidget {
  @override
  _NewDineInState createState() => _NewDineInState();
}

class _NewDineInState extends State<NewDineIn> {
  List<Meeting> meetings;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SfCalendar(
            view: CalendarView.workWeek,
            dataSource: MeetingDataSource(_getDataSource()),
            timeSlotViewSettings: TimeSlotViewSettings(
                startHour:11,
                endHour: 22,
                nonWorkingDays: <int>[]),
            monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          )),
    );
  }
  List<Meeting> _getDataSource() {
    meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'booked', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}