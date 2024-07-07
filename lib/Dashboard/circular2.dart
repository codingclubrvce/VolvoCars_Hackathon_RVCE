import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularProgressBar2 extends StatelessWidget {
  final int breakdownsEncountered;
  final int totalBreakdowns;

  CircularProgressBar2({
    required this.breakdownsEncountered,
    required this.totalBreakdowns,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (breakdownsEncountered / totalBreakdowns) * 100;
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 3, // Spread radius
            blurRadius: 5, // Blur radius
            offset: Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            animation: true,
            animationDuration: 1200,
            radius: 50.0,
            lineWidth: 10.0,
            percent: progress / 100,
            center: Text(
              "$progress%",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            progressColor: Color(0xFF182871),
            backgroundColor: Colors.black12, // Transparent background for circular progress
          ),
          SizedBox(height: 8),
          Text(
            'Assembly Failures',
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
