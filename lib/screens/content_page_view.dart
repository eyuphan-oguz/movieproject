import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieproject/screens/my_content_page_view.dart';


class ContentPageView extends StatefulWidget {
  const ContentPageView({super.key});

  @override
  State<ContentPageView> createState() => _ContentPageViewState();
}

class _ContentPageViewState extends State<ContentPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
           return Center(child: Text("yukleniyor",style: TextStyle(color: Colors.white),));
        }else if (snapshot.hasData){
          return MyContentPageView();
        }else{
          return Center(child: Text("giris yap",style: TextStyle(color: Colors.white)));
        }
        }
      ),
    );
  }
}