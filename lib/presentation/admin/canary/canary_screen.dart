import 'package:flutter/material.dart';

class CanaryScreen extends StatefulWidget {
  const CanaryScreen({super.key});

  @override
  State<CanaryScreen> createState() => _CanaryScreenState();
}

class _CanaryScreenState extends State<CanaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text('Daftar Burung'),
                Spacer(),
                TextButton(onPressed: () {}, child: Text('Selengkapnya')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
