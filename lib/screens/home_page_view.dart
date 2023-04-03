import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieproject/core/widgets/button_widget.dart';
import 'package:movieproject/product/constant/padding.dart';
import 'package:movieproject/product/utils/utils.dart';
import 'package:movieproject/resources/content_method.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
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

    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: ProjectPadding().mainPadding,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('content').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      color: Colors.transparent,
                      width: 100,
                      height: 200,
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
                                      child: _stackBuild(
                                          size: size,
                                          snapshot: snapshot,
                                          index: index, favoriteContent: contentList));
                                });
                          },
                          child: Image.network(
                              snapshot.data!.docs[index]["contentImageUrl"])));
                },
              ),
            );
          },
        ),
      ),
    ));
  }

  ShapeBorder _showModalBottomSheetShapeBorder(){
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20)),
  );}

  Widget _stackBuild(
      {required Size size,
      required AsyncSnapshot<QuerySnapshot> snapshot,
      required int index,
      required List<String> favoriteContent}) {
    return Stack(
      children: [
        Container(
          width: size.width * 1,
          height: size.height * 0.6,
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
                            Icons.close_rounded,
                            color: Colors.white,
                          )),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 25,
                        child: Text('${snapshot.data!.docs[index]["maturityLevel"]}+',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white, fontWeight: FontWeight.w900)),
                      )
                    ],
                  ),
                  Text(snapshot.data!.docs[index]["title"],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                  SizedBox(height: size.height*0.03,),        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _showModalBottomSheetTitle(title: "Release Date"),
                          Text(snapshot.data!.docs[index]["releaseDate"],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          _showModalBottomSheetTitle(title: "Type"),
                          Text(snapshot.data!.docs[index]["type"],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          _showModalBottomSheetTitle(title: "IMDB"),
                          Text(snapshot.data!.docs[index]["imdb"],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: size.height*0.02,), 
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: _showModalBottomSheetTitle(title: "Description"),
                    subtitle: Text(snapshot.data!.docs[index]["description"],
                        style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: size.height*0.01,), 
                  Row(
                    children: [
                      _showModalBottomSheetTitle(title: "Director: "),
                      Text(snapshot.data!.docs[index]["director"],
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  SizedBox(height: size.height*0.01,), 
                  Column(children: [
                    Text("Actors",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.grey)),
                          SizedBox(height: size.height*0.01,), 
                  Container(
                    height: size.height*0.02,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var item in snapshot.data!.docs[index]["actors"])
                          Text("${item} | ", style: TextStyle(color: Colors.white)),
                            
                      ],
                    ),
                  ),
                  ],),
                  SizedBox(height: size.height*0.01,), 
                  ButtonWidget(
                      onPressed: () async{
                        if(FirebaseAuth.instance.currentUser==null){
                          showSnackBar(context, "Lütfen oturum açınız.");
                        }else{
                          await ContentMethod().favoriteContent(postId: snapshot.data!.docs[index]["uid"], userId: FirebaseAuth.instance.currentUser!.uid, likes: favoriteContent);
                          return showSnackBar(context, "Listeme Eklendi");
                        }
                      },
                      buttonText: "Listeme Ekle",
                      size: size,
                      backgroundColor: Colors.red)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _showModalBottomSheetTitle({required String title}){
    return Text(title,style: TextStyle(color: Colors.grey));
  }

}
