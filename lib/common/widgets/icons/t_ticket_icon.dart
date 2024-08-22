import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class TicketDetailIcons extends StatelessWidget {
  const TicketDetailIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.circle_outlined,
          color: Colors.grey,
          size: 14,
        ),
        Container(
          width: 1,
          height: 65, // adjust as needed
          color: Colors.grey,
        ),
        Transform.rotate(
          angle: 3.14159 / 2,
          child: const Icon(
            Iconsax.send_1,
            color: Colors.grey,
            size: 14,
          ),
        ),
        Container(
          width: 1,
          height: 65, // adjust as needed
          color: Colors.grey,
        ),
        const Icon(
          Icons.circle_outlined,
          color: Colors.grey,
          size: 14,
        ),
      ],
    );
  }
}