import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaitingIndicatorPage extends StatelessWidget {
  WaitingIndicatorPage({super.key});

  final spinkit = SpinKitSquareCircle(
    color: Color(0xff01D1B19),
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: spinkit,
      )
    );
  }
}
