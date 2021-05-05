import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testpp/auth/userdata.dart';
import 'package:testpp/profileinfo.dart';

class slide extends StatefulWidget {
  String name;
  String email;
  String photourl;
  slide({this.name, this.email, this.photourl});
  @override
  _slideState createState() =>
      _slideState(name: name, email: email, photourl: photourl);
}

class _slideState extends State<slide> {
  String name;
  String email;
  String photourl;

  _slideState({this.name, this.email, this.photourl});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
              height: 175,
              width: 310,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/b.jpg',
                    fit: BoxFit.fill,
                  ),
                  Container(
                    width: 310,
                    height: 150,
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    photourl,
                                    fit: BoxFit.cover,
                                  ),
                                ))
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
          Container(
            width: 300,
            height: 224,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => profiledetails()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                    ),
                    title: Text('Setting'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {},
                  ),
                  ListTile()
                ]),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(top: 110),
            width: 200,
            height: 50,
            child: Text('Developed By Sandeep Kumar'),
          )
        ],
      ),
    );
  }
}
