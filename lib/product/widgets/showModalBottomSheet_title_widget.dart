import 'package:flutter/material.dart';
import 'package:movieproject/product/constant/colors.dart';

class ShowModalBottomSheetTitleWidget extends StatelessWidget {
  const ShowModalBottomSheetTitleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Text(title,
     style: textStyle(context));
  }

  TextStyle textStyle (context){
    return Theme.of(context)
       .textTheme
       .titleLarge!
       .copyWith(color: ProjectColor().showModalBottomSheetTitleColor,fontWeight: FontWeight.w700);
  }
}