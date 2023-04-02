import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String uid;
  final String email;
  final String name;
  final List<String> myContentList;
  final List<String> myPostList;
  



  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.myContentList,
    required this.myPostList
  });

  Map<String, dynamic> toJson() =>{
    "uid":uid,
    "email":email,
    "name":name,
    "myContentList":myContentList,
    "myPostList":myPostList,
  };

  static UserModel fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String, dynamic>;
    return UserModel(
      uid:snapshot["uid"],
      email:snapshot["email"],
      name:snapshot["name"],
      myPostList:snapshot["myPostList"],
      myContentList:snapshot["myContentList"],
    );
  }

}