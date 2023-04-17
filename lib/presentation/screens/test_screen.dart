import 'package:Caput/presentation/widgets/util/buttons/caput_button_secondary.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget{

  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Hallo Welt :)"),
            CaputButtonSecondary(icon: Icons.add, onPressed: () => {}),
            const Text("data"),
            TextButton(onPressed: () => {}, child: const Text("Test"))
          ],
        )
      ),
    );
  }

}