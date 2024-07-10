
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../Widgets/BottomNavBar.dart';

void main() {
  runApp(MaterialApp(
    home: AppointmentDragDrop(),
  ));
}

class CustomAppointmentWidget extends StatelessWidget {
  final String subject;
  final Color color;

  const CustomAppointmentWidget({required this.subject, required this.color});

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(subject, style: TextStyle(color: Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Edit"),
                onTap: () {
                  Navigator.pop(context, "Edit");
                },
              ),
              ListTile(
                title: Text("Remove"),
                onTap: () {
                  Navigator.pop(context, "Remove");
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        // Handle the selected option
        print("Selected option: $value");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showOptionsDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Color(0xff2b55b8),
                width: 5.0,
                height: 120.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                subject,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "xx:xx",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentDragDrop extends StatefulWidget {
  const AppointmentDragDrop({Key? key}) : super(key: key);

  @override
  AppointmentDragDropState createState() => AppointmentDragDropState();
}

class AppointmentDragDropState extends State<AppointmentDragDrop> {
  late _DataSource _events;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _events = _addAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          _showDatePicker(context, setState);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SfCalendar(
                    key: UniqueKey(), // Force rebuild when changing date
                    initialDisplayDate: _selectedDate,
                    allowedViews: const [
                      CalendarView.month,
                      CalendarView.day,
                      CalendarView.week,
                      CalendarView.workWeek,
                      CalendarView.timelineDay,
                      CalendarView.timelineWeek,
                      CalendarView.timelineWorkWeek,
                      CalendarView.schedule,
                    ],
                    dataSource: _events,
                    allowDragAndDrop: true,
                    timeSlotViewSettings: TimeSlotViewSettings(
                      timeIntervalHeight: 100,
                      timeIntervalWidth: 200,
                    ),
                    appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
                      final Appointment appointment = details.appointments.first;
                      return Container(
                        width: 50.0, // Set your desired width here
                        height: 100.0, // Set your desired height here
                        child: CustomAppointmentWidget(subject: appointment.subject, color: appointment.color),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        tooltip: 'Increment',
        child: IconButton(onPressed: () {}, icon: SvgPicture.asset('assets/images/lines.svg')),
        shape: CircleBorder(),
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }

  void _showDatePicker(BuildContext context, StateSetter setState) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  _DataSource _addAppointments() {
    List<Appointment> _appointmentCollection = <Appointment>[];

    final DateTime today = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour);

    _appointmentCollection.add(Appointment(
      startTime: today,
      endTime: today.add(const Duration(hours: 1)),
      subject: 'Running Club',
      color: Colors.lightBlueAccent,
    ));

    _appointmentCollection.add(Appointment(
      startTime: today.add(const Duration(days: -1, hours: 2)),
      endTime: today.add(const Duration(days: -1, hours: 3)),
      subject: 'Language arts',
      color: Colors.white,
    ));

    _appointmentCollection.add(Appointment(
      startTime: today.add(const Duration(days: -2, hours: 5)),
      endTime: today.add(const Duration(days: -2, hours: 6)),
      subject: 'Math',
      color: Colors.pink,
    ));

    _appointmentCollection.add(Appointment(
      startTime: today.add(const Duration(days: 2, hours: 5)),
      endTime: today.add(const Duration(days: 2, hours: 6)),
      subject: 'Social Studies',
      color: Colors.pink,
    ));

    _appointmentCollection.add(Appointment(
      startTime: today.add(const Duration(days: 3, hours: 3)),
      endTime: today.add(const Duration(days: 3, hours: 4)),
      subject: 'Advance Math',
      color: Colors.deepPurple,
    ));

    return _DataSource(_appointmentCollection);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments=source;
    }
}