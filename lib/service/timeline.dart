import 'package:flutter/material.dart';
import 'package:testpp/service/read.dart';
import 'package:testpp/service/write.dart';
import 'package:testpp/slidebar.dart';
import 'package:icon/icon.dart';

class timeline extends StatefulWidget {
  String name;
  String email;
  String photourl;
  timeline({this.email, this.name, this.photourl});
  @override
  _timelineState createState() =>
      _timelineState(email: email, name: name, photourl: photourl);
}

class _timelineState extends State<timeline> {
  String name;
  String email;
  String photourl;
  _timelineState({this.email, this.name, this.photourl});
  int _currentpage = 0;
  var _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baat Cheet'),
      ),
      drawer: slide(
        name: name,
        email: email,
        photourl: photourl,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _currentpage = value;
          });
        },
        children: [read(), Write()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentpage,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Read'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), title: Text('Write'))
        ],
        onTap: (index) {
          setState(() {
            _currentpage = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          });
        },
      ),
    );
  }
}
