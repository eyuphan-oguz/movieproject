import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieproject/product/widgets/content_widget.dart';


class SelectedCategoryPageView extends StatefulWidget {
  const SelectedCategoryPageView({super.key, required this.selectedType, required this.size});
  final String selectedType;
  final Size size;
  @override
  State<SelectedCategoryPageView> createState() => _SelectedCategoryPageViewState();
}

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



class _SelectedCategoryPageViewState extends State<SelectedCategoryPageView> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      getContent(FirebaseAuth.instance.currentUser);
    });
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('content').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError){
            return Text("ERROR");
          }
    
          if (snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator.adaptive();
          }
    
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index){
              if(snapshot.data!.docs[index]["type"]==widget.selectedType){
                print(snapshot.data!.docs.length);
                return Container(
                            color: Colors.transparent,
                            width: widget.size.width*0.25,
                            height: widget.size.height*0.2,
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