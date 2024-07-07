import 'package:flutter/material.dart';
import 'package:hackathon/Widgets/Translucent%20card.dart';
class OperationsCard extends StatelessWidget {
  const OperationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Color(0xFF182871),
          // gradient: LinearGradient(
          //   colors: [
          //     Color(0xFF182871),
          //     Color(0xFF182871),
          //     Color(0xFF141414),
          //   ],
          //   begin: Alignment.bottomRight,
          //   end: Alignment.topLeft,
          // ),

        ),

        child: FrostedGlassBox(path: "assets/images/asset_assembly.svg", title: "Asset Assembly",
            description: "Asset assembly at Volvo Bengaluru involves precise coordination and high-quality standards to ensure efficient and reliable vehicle production.")

    );
  }
}
