import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieproject/core/widgets/button_widget.dart';
import 'package:movieproject/product/constant/colors.dart';
import 'package:movieproject/product/constant/padding.dart';
import 'package:movieproject/product/widgets/dots_effect_widget.dart';
import 'package:movieproject/screens/login_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionPageView extends StatefulWidget {
  const IntroductionPageView({Key? key}) : super(key: key);

  @override
  _IntroductionPageViewState createState() => _IntroductionPageViewState();
}

class _IntroductionPageViewState extends State<IntroductionPageView> {
  final controller=PageController();
  bool isLastPage=false;
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("NETFLIX",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25),),
          centerTitle: false,
        ),
        body: Padding(
          padding: ProjectPadding().mainPadding,
          child: Stack(
            children: [
              PageView(
              onPageChanged: (index){
                setState(() => isLastPage=index==3);
              },
              controller: controller,
              children: [
                buildPage(urlImage: "assets/images/jpg/introduction1.jpg", title1: "İstediğiniz",title2: "cihazda izleyin",desc: "Telefonda, tablette, bilgisayarda, TV'de; ekstra ücret ödemeden tüm cihazlarda izleyin.", size: size),
                buildPage(urlImage: "assets/images/jpg/introduction2.jpg", title1: "Netflix: Yeni",title2: "Yol Arkadaşın",desc: "Uçakta, otobüste, metrobüste... İnternet olmasa da Netflix'ten indirdiklerini izle!", size: size),
                buildPage(urlImage: "assets/images/jpg/introduction3.jpg", title1: "Eğlence çok,",title2: "taahüt yok",desc: "Bugün katılın, istediğiniz zaman iptal edin.", size: size),
                         
                      
                      
                      
              ],
                        ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                DotsEffectWidget(controller: controller, onDotClicked: (int index ) { 
                controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
               }, count: 3,),
               SizedBox(height: size.height*0.03,),
              ButtonWidget(onPressed: () { 
                  Navigator.pushReplacementNamed(context, '/login');
                 }, buttonText: 'OTURUM AÇ', size: size, backgroundColor: ProjectColor().redButtonColor,),
              ],),
            )
            
            ],
          ),
        ),
        
      ),
    );
  }



  Widget bottomDesign(){
    return Container();
  }



  Widget buildPage({required String urlImage,required String title1,required String title2,required String desc,required Size size}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(child: Image.asset(urlImage,fit: BoxFit.fitWidth,width:MediaQuery.of(context).size.width*1,height: MediaQuery.of(context).size.height*0.45)),
        Column(
          children: [
            Text(title1,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
            Text(title2,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: size.height*0.04,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(desc,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),textAlign: TextAlign.center,),
            ),
          ],
        ),
      ],
    );
  }
}