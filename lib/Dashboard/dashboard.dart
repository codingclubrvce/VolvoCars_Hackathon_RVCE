import 'package:flutter/material.dart';
import 'package:hackathon/Dashboard/bargraph.dart';
import 'package:hackathon/Dashboard/circular2.dart';
import 'package:hackathon/Dashboard/circularindicator.dart';
import '../Widgets/BottomNavBar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0XFF182871),
          title: Text(
            "Volvo",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
              color: Colors.white,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 130,
                  width: 500,
                  color: Color(0xFF182871),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 40),
                        child: Text(
                          "Dashboard & Analytics",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      NavyBlueCard(),
                      SizedBox(height: 8),
                      Divider(),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Breakdowns Compared to Historical Peaks",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            CircularProgressBar(
                              breakdownsEncountered: 15,
                              totalBreakdowns: 100,
                            ),
                            SizedBox(width: 20),
                            CircularProgressBar2(
                              breakdownsEncountered: 5,
                              totalBreakdowns: 100,
                            ),
                          ],
                        ),
                      ),


                      NavyBlueCard1(),
                      SizedBox(height: 8),
                      Text(
                        "Lead time operations (in minutes)",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                          color: Colors.black,
                        ),
                      ),

                      BarChartExample(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
}

class NavyBlueCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 18,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.blue[900],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(

              "Being your industry buddy, this app embodies Volvo's legacy of excellence, empowering employees to seamlessly manage assets with precision, ensuring superior quality and customer satisfaction.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left:110.0),
              child: Text(
                textAlign: TextAlign.end,
                "-crafted for Volvo Cars, Bangalore.",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class NavyBlueCard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 3, bottom: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                          SizedBox(height: 10),
              Text(
                "'Volvo: Engineering Marvels, Setting Standards in Manufacturing Excellence'",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 15),

            ],
          ),
        ),
      ),
    );
  }
}

