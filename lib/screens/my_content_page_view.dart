import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyContentPageView extends StatefulWidget {
  const MyContentPageView({super.key});

  @override
  State<MyContentPageView> createState() => _MyContentPageViewState();
}

class _MyContentPageViewState extends State<MyContentPageView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid) // oturum açmış kullanıcının uid'si
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black,),
            );
          }

          print(snapshot.data.data());
          print(snapshot.data.data()["myContentList"]);

          List<dynamic> myPostList = snapshot.data.data()["myContentList"];
          return ListView.builder(
            itemCount: myPostList.length,
            itemBuilder: (context, index) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('content')
                    .doc(myPostList[index]) // myPostList içindeki ilan id'si
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    print("bura calisti");
                    return CircularProgressIndicator();
                  }
                  DocumentSnapshot advertisement = snapshot.data!;
                  print("simdi bura calisti");
                  print(advertisement['title']);
                  
                  return ListTile(
                    title: Text(advertisement['title'],style: TextStyle(color: Colors.white),),
                    subtitle: Text(advertisement['description'],style: TextStyle(color: Colors.white)),
                    trailing: Text(advertisement['type'],style: TextStyle(color: Colors.white)),
                    leading: IconButton(icon: Icon(Icons.remove,),onPressed: ()async{
                    },),
                  );
                },
              );
            },
          );
        },
      ),
    );
        }
      
    
  }
