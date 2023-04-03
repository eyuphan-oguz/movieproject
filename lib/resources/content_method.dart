

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieproject/model/content_model.dart';

class ContentMethod{
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  FirebaseAuth auth=FirebaseAuth.instance;



    Future<String> createContent({
      required String title,
      required String description,
      required List<String> actors,
      required String director,
      required String maturityLevel,
      required String type,
      required String imdb,
      required String releaseDate,
      required String contentImageUrl
      })async{

    String res="Some error occurred";

    try{
      if(
        title.isNotEmpty && 
        description.isNotEmpty && 
        actors.isNotEmpty && 
        director.isNotEmpty && 
        maturityLevel.isNotEmpty &&
        type.isNotEmpty &&
        imdb.isNotEmpty &&
        releaseDate.isNotEmpty &&
        contentImageUrl.isNotEmpty
        ){
          final DocumentReference ref = _firestore.collection("content").doc();
          ContentModel contentModel=ContentModel(uid: ref.id.toString(),authorId: auth.currentUser!.uid, title: title, description: description, actors: actors, contentImageUrl: contentImageUrl, director: director, imdb: imdb, maturityLevel: maturityLevel, releaseDate: releaseDate, type: type, );
          await _firestore.collection("content").doc(ref.id.toString()).set(contentModel.toJson());
          res = "success";
        }else{
          res = "Lütfen tüm alanları doldurunuz.";
        }
    }catch(err){
      res=err.toString();
    }
    
    return res;


  }

   Future<String> favoriteContent({required String postId, required String userId,required  List<String> likes} ) async {
    String res = "Some error occurred";

    try {
        if (likes.contains(postId)){
         await _firestore.collection('users').doc(userId).update({
          'myContentList': FieldValue.arrayRemove([postId])
        });
        }else{
          await _firestore.collection('users').doc(userId).update({
          'myContentList': FieldValue.arrayUnion([postId])
        });
        }
        // if the likes list contains the user uid, we need to remove it
        
      
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }



}