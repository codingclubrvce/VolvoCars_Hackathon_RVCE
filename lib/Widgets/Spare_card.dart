import 'package:flutter/material.dart';
import 'package:hackathon/Widgets/Translucent%20card.dart';
class SpareCard extends StatelessWidget {
  const SpareCard({super.key});

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

        child: FrostedGlassBox(path: "assets/images/settings-line-icon.svg", title: "Spare Parts",
            description: "Volvo Bengaluru excels in efficient spare parts management, ensuring timely availability, superior quality, and exceptional customer service.")

    );
  }
}
