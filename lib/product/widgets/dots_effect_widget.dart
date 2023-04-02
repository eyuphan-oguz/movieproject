import 'package:flutter/material.dart';
import 'package:movieproject/product/constant/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class DotsEffectWidget extends StatelessWidget {
  const DotsEffectWidget({super.key, required this.controller, required this.onDotClicked, required this.count});
  final PageController controller;
  final Function(int) onDotClicked;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffectStyle(),
      onDotClicked: (index)=>onDotClicked,
    );
  }




  ExpandingDotsEffect ExpandingDotsEffectStyle(){
    return  ExpandingDotsEffect(
      spacing: 10,
      radius:  8.0,
      dotWidth:  8.0,
      expansionFactor: 4,
      dotHeight:  8.0,
      dotColor: ProjectColor().deactiveDotsColor,
      activeDotColor: ProjectColor().activeDotsColor
    );
  }

  
}