import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movieproject/product/constant/category.dart';
import 'package:movieproject/product/constant/icon.dart';


class CategoryMenu extends StatefulWidget {
  const CategoryMenu({super.key, required this.size});
  final Size size;

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: Stack(
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
              sigmaX: 16,
              sigmaY: 16
             ),
             child: Container(
                width: widget.size.width,
                height: widget.size.height,
                decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
             ),
             child: Container(
              height:widget.size.height,
               child: ListView.builder(
                   itemCount: categoryList.length,
                   itemBuilder: (BuildContext context, int index) {
                   return ListTile(
                title: Text(categoryList[index],style: TextStyle(color: Colors.white60),),
                onTap: () {
                  print(categoryList[index]);
                },
                   );
                   }
                   ),
             ),
             )),
          ),
          Positioned(bottom: widget.size.height/15,left: widget.size.width/2.2,child: CircleAvatar(
            radius: 23,
            backgroundColor: Colors.white,

            child: IconButton(icon:Icon(ProjectIcon().deleteIcon,color: Colors.black,),onPressed: (){
              Navigator.pop(context);
            },)))
        ],
      ),
    );
  }
}