import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PlalylistEmpty extends StatelessWidget {
  const PlalylistEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/Animation - 1706003987385 (1).json',
            width: 300,
          ),
          const Text('No videos found'),
        ],
      ),
    );
  }
}
