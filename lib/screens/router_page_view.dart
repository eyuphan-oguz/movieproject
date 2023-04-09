import 'package:flutter/material.dart';
import 'package:movieproject/screens/content_page_view.dart';
import 'package:movieproject/screens/home_page_view.dart';
import 'package:movieproject/screens/publish_content_page_view.dart';


class RouterPageView extends StatefulWidget {
  const RouterPageView({Key? key}) : super(key: key);

  @override
  State<RouterPageView> createState() => _RouterPageViewState();
}

class _RouterPageViewState extends State<RouterPageView> {
  int _currentIndex = 0;

  final List<Widget> _children = [HomePageView(),PublishContentPageView(),ContentPageView()];

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
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFF4CA6A8),
        selectedIconTheme: IconThemeData(color: Color(0xFF4CA6A8)),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add_check_rounded),
            label: 'İlan / Başvuru',
          ),

        ],
      ),
    );
  }
}