import 'package:flutter/material.dart';
import 'package:hackathon/Widgets/Translucent%20card.dart';
class FailureCard extends StatelessWidget {
  const FailureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
          gradient: LinearGradient(
            colors: [
              Color(0xFF182871),
              Color(0xFF182871),
              Color(0xFF141414),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),

        ),

        child: FrostedGlassBox(path: "assets/images/close-icon.svg", title: "Serviceability",
            description: "Failures in asset assembly at the Volvo plant in Bengaluru include component defects, alignment issues, software malfunctions, and machinery breakdowns, impacting productivity.")

    );
  }
}
