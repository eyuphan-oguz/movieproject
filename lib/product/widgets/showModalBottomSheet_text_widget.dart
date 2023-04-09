import 'package:flutter/material.dart';


class ShowModalBottomSheetTextWidget extends StatelessWidget {
  const ShowModalBottomSheetTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
       style: Theme.of(context)
       .textTheme
       .titleMedium!
       .copyWith(color: Colors.white));
  }
}