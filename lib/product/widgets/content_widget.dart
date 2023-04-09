import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieproject/core/widgets/button_widget.dart';
import 'package:movieproject/product/constant/icon.dart';
import 'package:movieproject/product/utils/utils.dart';
import 'package:movieproject/resources/content_method.dart';

import 'circle_maturity_level_widget.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key, required this.size, required this.snapshot, required this.index, required this.favoriteContent});
  final Size size;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;
  final List<String> favoriteContent;

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.size.width * 1,
          height: widget.size.height * 0.6,
          color: Colors.black.withOpacity(0.9),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            ProjectIcon().deleteIcon,
                            color: Colors.white,
                          )),
                      CircleMaturityLevel(age:widget.snapshot.data!.docs[widget.index]["maturityLevel"] ,)
                    ],
                  ),
                  Text(widget.snapshot.data!.docs[widget.index]["title"],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                  SizedBox(height: widget.size.height*0.03,),        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _showModalBottomSheetTitle(title: "Release Date"),
                          Text(widget.snapshot.data!.docs[widget.index]["releaseDate"],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          _showModalBottomSheetTitle(title: "Type"),
                          Text(widget.snapshot.data!.docs[widget.index]["type"],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          _showModalBottomSheetTitle(title: "IMDB"),
                          Text(widget.snapshot.data!.docs[widget.index]["imdb"],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: widget.size.height*0.02,), 
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: _showModalBottomSheetTitle(title: "Description"),
                    subtitle: Text(widget.snapshot.data!.docs[widget.index]["description"],
                        style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: widget.size.height*0.01,), 
                  Row(
                    children: [
                      _showModalBottomSheetTitle(title: "Director: "),
                      Text(widget.snapshot.data!.docs[widget.index]["director"],
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  SizedBox(height: widget.size.height*0.01,), 
                  Column(children: [
                    Text("Actors",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.grey)),
                          SizedBox(height: widget.size.height*0.01,), 
                  Container(
                    height: widget.size.height*0.02,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var item in widget.snapshot.data!.docs[widget.index]["actors"])
                          Text("${item} | ", style: TextStyle(color: Colors.white)),
                            
                      ],
                    ),
                  ),
                  ],),
                  SizedBox(height: widget.size.height*0.01,), 
                  ButtonWidget(
                      onPressed: () async{
                        if(FirebaseAuth.instance.currentUser==null){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cancel,color: Colors.red,size: 50,),
                                      Text("Lütfen oturum açınız.",style: TextStyle(color: Colors.white),)
                                    ],
                                  ),);}
                          );
                          showSnackBar(context, "Lütfen oturum açınız.");
                        }else{
                          await ContentMethod().favoriteContent(postId: widget.snapshot.data!.docs[widget.index]["uid"], userId: FirebaseAuth.instance.currentUser!.uid, likes: widget.favoriteContent);
                          return showSnackBar(context, "Listeme Eklendi");
                        }
                      },
                      buttonText: "Listeme Ekle",
                      size: widget.size,
                      backgroundColor: Colors.red)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
    ShapeBorder _showModalBottomSheetShapeBorder(){
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20)),
  );}

    Widget _showModalBottomSheetTitle({required String title}){
    return Text(title,style: TextStyle(color: Colors.grey));
  }
}