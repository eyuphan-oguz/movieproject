import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movieproject/product/constant/padding.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: ProjectPadding().mainPadding,
        child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('content').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Bir hata oluştu');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator.adaptive();
                    }
  
                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context ,int index){                                                    
                          return Container(
                            color: Colors.transparent,
                            width: 100,
                            height: 200,
                            child: GestureDetector(
                              onTap: (){
                                showModalBottomSheet(context: context, builder: (BuildContext context){
                                  return Container(
                                    height: 500,
                                  );
                                });
                              },
                              child: Image.network(snapshot.data!.docs[index]["contentImageUrl"])));

                       
                        },
                      ),
                    );
                  },
                ),
      ),
    ));
  }
}