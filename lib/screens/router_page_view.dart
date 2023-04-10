import 'package:flutter/material.dart';
import 'package:movieproject/screens/content_page_view.dart';
import 'package:movieproject/screens/home_page_view.dart';
import 'package:movieproject/screens/publish_content_page_view.dart';

import '../product/widgets/watch_later_content_widget.dart';


class RouterPageView extends StatefulWidget {
  const RouterPageView({Key? key}) : super(key: key);

  @override
  State<RouterPageView> createState() => _RouterPageViewState();
}

class _RouterPageViewState extends State<RouterPageView> {
  int _currentIndex = 0;

  final List<Widget> _children = [HomePageView(),PublishContentPageView(),MoviesPage()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ios_share),
            label: 'İçerik Paylaş',
          ),
        
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Listem',
          ),

        ],
      ),
    );
  }
}