import 'dart:async';

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class SplashScreenPageView extends StatefulWidget {
  const SplashScreenPageView({Key? key}) : super(key: key);

  @override
  State<SplashScreenPageView> createState() => _SplashScreenPageViewState();
}

class _SplashScreenPageViewState extends State<SplashScreenPageView> {
  


  @override
  void initState() {
    
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacementNamed(context, '/home'),
      
      
    );
  }
  

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Lottie.network(
        'https://assets1.lottiefiles.com/private_files/lf30_is6flrfu.json',
        repeat: false,
        frameRate: FrameRate(60),
        fit: BoxFit.contain,
      ),
    );
  }
}
