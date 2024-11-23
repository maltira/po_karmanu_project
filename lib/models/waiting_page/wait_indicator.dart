import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:po_karmanu_project/theme/theme.dart';

class WaitingIndicator extends StatelessWidget {
  WaitingIndicator({super.key});

  final _spinkit = SpinKitRing(
    color: ListOfColors.primaryBlack.withOpacity(0.8),
    duration: Duration(milliseconds: 300),
    lineWidth: 3,
    size: 25.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: _spinkit,
      ),
    );
  }
}
