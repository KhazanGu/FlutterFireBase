import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'MessagePage.dart';
import 'ProfilePage.dart';
import 'MapPage.dart';

class MainPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPageState();
  }
}


class _MainPageState extends State<MainPage> {

  int _index = 0;

  final List<Widget> _children = [HomePage(), MapPage(), ProfilePage()];

  void _tapTab(int index) {

    setState(() {
      
      _index = index;

    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: _children[_index],

      bottomNavigationBar: BottomNavigationBar(
        
        onTap: _tapTab,
        
        currentIndex: _index,

        items: [

          BottomNavigationBarItem(
            
            icon: Icon(Icons.home),

            title: Text("Home"),
            
          ),

          BottomNavigationBarItem(
            
            icon: Icon(Icons.map),

            title: Text("Map"),
            
          ),

          BottomNavigationBarItem(
            
            icon: Icon(Icons.person),

            title: Text("Profile"),
            
          )

        ]
        
      ),

    );

  }

}