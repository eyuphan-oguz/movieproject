import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieproject/model/content_model.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({ Key? key }) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  CarouselController _carouselController = new CarouselController();
  int _current = 0;

  List<dynamic> _movies = [
    {
      'title': 'Black Widow',
      'image': 'https://www.moviepostersgallery.com/wp-content/uploads/2020/08/Blackwidow2.jpg',
      'description': 'Black Widow'
    },
    {
      'title': 'The Suicide Squad',
      'image': 'https://static.wikia.nocookie.net/headhuntersholosuite/images/7/77/Suicide_Squad%2C_The.jpg/revision/latest?cb=20210807172814',
      'description': 'The Suicide Squad'
    },
    {
      'title': 'Godzilla Vs Kong',
      'image': 'https://pbs.twimg.com/media/EwTsO9CVcAUxoMM?format=jpg&name=large',
      'description': 'Godzilla Vs Kong'
    }
  ];

List<String> favoriteContentList = [];
DocumentSnapshot? contentModelList;

List<DocumentSnapshot> contentDocumentList=[];

  Future<List<String>> getFavoriteContentMethod(User? user) async {
  List<String> favoriteContent = [];
  await FirebaseFirestore.instance
    .collection('users')
    .doc(user?.uid)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        favoriteContent = List<String>.from(documentSnapshot.get('myContentList'));
        favoriteContentList=favoriteContent;
      }

      for(int i = 0 ; i<favoriteContent.length; i++){
        setState(() {
          getContentById(favoriteContent[i]);
        });
      }

    
  });

  return favoriteContent;
}



 Future<void> getContentById(String id) async {
    final collectionRef = FirebaseFirestore.instance.collection('content');
    final doc = await collectionRef.doc(id).get();
    setState(() {
      contentModelList = doc.exists ? doc : null;
      contentDocumentList.add(contentModelList!);
    });
  }




 @override
  void initState() {
    super.initState();
    getFavoriteContentMethod(FirebaseAuth.instance.currentUser);
  } 

  @override
  Widget build(BuildContext context) {
    setState(() {
      print(favoriteContentList);
      //print(contentDocumentList[_current]["title"]); 

    });
    return Scaffold(
      body: Container( 
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            if (contentDocumentList.length > 0) 
            Image.network(contentDocumentList[_current]["contentImageUrl"], fit: BoxFit.cover),
              
              

           // Image.network(contentDocumentList[_current]["contentImageUrl"], fit: BoxFit.cover),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                    ]
                  )
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 500.0,
                  aspectRatio: 16/9,
                  viewportFraction: 0.70,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                carouselController: _carouselController,

                items: contentDocumentList.map((movie) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 320,
                                margin: EdgeInsets.only(top: 30),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(movie['contentImageUrl'], fit: BoxFit.cover),
                              ),
                              SizedBox(height: 20),
                              Text(movie['title'], style: 
                                TextStyle(
                                  fontSize: 16.0, 
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              // rating
                              SizedBox(height: 20),
                              Container(
                                child: Text(movie['description'], style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey.shade600
                                ), textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 20),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity: _current == _movies.indexOf(movie) ? 1.0 : 0.0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.star, color: Colors.yellow, size: 20,),
                                            SizedBox(width: 5),
                                            Text('4.5', style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey.shade600
                                            ),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time, color: Colors.grey.shade600, size: 20,),
                                            SizedBox(width: 5),
                                            Text('2h', style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey.shade600
                                            ),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Row(
                                          children: [
                                            Icon(Icons.play_circle_filled, color: Colors.grey.shade600, size: 20,),
                                            SizedBox(width: 5),
                                            Text('Watch', style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey.shade600
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      );
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}