import 'package:flutter/material.dart';
import 'package:movieproject/product/constant/colors.dart';


class ShowModalBottomSheetTextWidget extends StatelessWidget {
  const ShowModalBottomSheetTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
       style: textStyle(context));
  }

  TextStyle textStyle (context){
    return Theme.of(context)
       .textTheme
       .titleMedium!
       .copyWith(color: ProjectColor().showModalBottomSheetTextColor);
  }
}