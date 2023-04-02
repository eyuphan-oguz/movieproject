import 'package:cloud_firestore/cloud_firestore.dart';

class ContentModel{
  final String title;
  final String description;
  final List<String> actors;//
  final String director;
  final String maturityLevel;
  final String type;//
  final String imdb;
  final String releaseDate;
  final String contentImageUrl;
  final String uid;
  final String authorId;


  const ContentModel({
    required this.title,
    required this.description,
    required this.actors,
    required this.director,
    required this.maturityLevel,
    required this.type,
    required this.imdb,
    required this.releaseDate,
    required this.contentImageUrl,
    required this.uid,
    required this.authorId
  });

  Map<String, dynamic> toJson() =>{
    "uid":uid,
    "title":title,
    "description":description,
    "actors":actors,
    "director":director,
    "maturityLevel":maturityLevel,
    "type":type,
    "imdb":imdb,
    "releaseDate":releaseDate,
    "contentImageUrl":contentImageUrl,
    "authorId":authorId,
  };



  static ContentModel fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String, dynamic>;
    return ContentModel(
      uid:snapshot["uid"],
      title:snapshot["title"],
      description:snapshot["description"],
      actors:snapshot["actors"],
      director:snapshot["director"],
      maturityLevel:snapshot["maturityLevel"],
      type:snapshot["type"],
      imdb:snapshot["imdb"],
      releaseDate:snapshot["releaseDate"],
      contentImageUrl:snapshot["contentImageUrl"],
      authorId:snapshot["authorId"],
    );
  }


}