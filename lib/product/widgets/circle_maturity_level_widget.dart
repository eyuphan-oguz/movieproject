import 'package:flutter/material.dart';

class CircleMaturityLevelWidget extends StatelessWidget {
  const CircleMaturityLevelWidget({super.key, required this.age});
  final String age; 

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.red,
      radius: 25,
      child: Text('${age}+',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w900))
    );
  }
}