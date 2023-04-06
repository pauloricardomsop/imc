import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color color;

  const Loading({Key? key, this.color = Colors.yellow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 40,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
