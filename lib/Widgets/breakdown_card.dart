import 'package:flutter/material.dart';
import 'package:hackathon/Widgets/Translucent%20card.dart';
class MaintenanceCard extends StatelessWidget {
  const MaintenanceCard({super.key});

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

        child: FrostedGlassBox(path: "assets/images/workshop-icon.svg", title: "Maintenance",
            description: "Ensuring precision and efficiency in every detail. Our commitment to excellence extends from cutting-edge automotive engineering to meticulous warehouse upkeep, ensuring seamless operations and customer satisfaction")

    );
  }
}
