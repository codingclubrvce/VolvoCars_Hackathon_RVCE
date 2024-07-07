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

          title: Text("Volvo",style: TextStyle(
              fontSize:18,fontWeight: FontWeight.bold,fontFamily: "Inter"   ,color: Colors.white       //this will be a variable text area, e.g. ffetch from the users name
          ),),

          leading:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),

          ),

          // titleSpacing: 0,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  height: 130,
                width: 500,
                color: Color(0xFF182871),
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 40),
                      child: Text("Dashboard & Analytics",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),

                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(width: 15,),
                          CircularProgressBar(breakdownsEncountered: 15, totalBreakdowns: 100),
                          SizedBox(width: 20,),
                          CircularProgressBar2(breakdownsEncountered: 5, totalBreakdowns: 100)

                        ],
                      ),


                    ),

                    BarChartExample()
                  ],
                ),
              )

            ],
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(),
      ),


    );
  }
}
