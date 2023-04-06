import 'package:flutter/material.dart';

class AdIcon extends StatelessWidget {
  const AdIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [
        Icon(
          Icons.movie_outlined,
          color: Color(0xFFFFFFFF),
          size: 42,
        ),
        Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            'AD',
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
