import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieproject/product/constant/colors.dart';
import 'package:movieproject/product/constant/padding.dart';
import 'package:movieproject/product/widgets/content_widget.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({super.key, required this.selectedType, required this.size});
  final String selectedType;
  final Size size;
  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {

  List<String> contentList = [];


  Future<List<String>> getContent(User? user) async {
  List<String> favoriteContent = [];

  await FirebaseFirestore.instance
    .collection('users')
    .doc(user?.uid)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        favoriteContent = List<String>.from(documentSnapshot.get('myContentList'));
        contentList=favoriteContent;
      }
  });

  return favoriteContent;
}


  @override
  Widget build(BuildContext context) {
    setState(() {
      getContent(FirebaseAuth.instance.currentUser);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedType,style: TextStyle(color: Colors.red,),
      )),
      body: Padding(
        padding:ProjectPadding().mainPadding,
        child: 
           StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('content').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError){
            return Text("ERROR");
          }
    
          if (snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator.adaptive();
          }
    
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
           maxCrossAxisExtent: 320,
           childAspectRatio: 2/2.8,
           crossAxisSpacing: 15,
           mainAxisSpacing: 15
        ), 
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index){
              if(snapshot.data!.docs[index]["type"]==widget.selectedType){
                print(snapshot.data!.docs.length);
                return Container(
                            color: Colors.transparent,
                            child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: _showModalBottomSheetShapeBorder(),
                                      builder: (BuildContext context) {
                                        var imdb = snapshot.data!.docs[index]["imdb"];
                                        var actor =
                                            snapshot.data!.docs[index]["imdb"];
                                        return BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 0.9, sigmaY: 0.9),
                                            child: ContentWidget(
                                                size: widget.size,
                                                snapshot: snapshot,
                                                index: index, favoriteContent: contentList));
                                      });
                                },
                                child: Image.network(
                                    snapshot.data!.docs[index]["contentImageUrl"])));
              }else{
                return Container();
              }
            }
            );
        }
      )
        
         ),
    );
  }

   ShapeBorder _showModalBottomSheetShapeBorder(){
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20)),
  );}
}