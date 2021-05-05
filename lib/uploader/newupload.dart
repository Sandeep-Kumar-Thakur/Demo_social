import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testpp/auth/userdata.dart';
import 'package:testpp/service/timeline.dart';

class withoutphoto extends StatefulWidget {
  String content;
  withoutphoto({this.content});
  @override
  _withoutphotoState createState() => _withoutphotoState(content: content);
}

class _withoutphotoState extends State<withoutphoto> {
  String content;
  _withoutphotoState({this.content});

  Userdetails _userdetails = Userdetails.instance;
  String username;
  String email;
  String profileurl;
  String uid;
  final db = Firestore.instance;
  final data = new DateTime.now();

  Future getdata() async {
    username = await _userdetails.username;
    email = await _userdetails.userEmail;
    profileurl = await _userdetails.profileurl;
    uid = await _userdetails.userid;
    setState(() {
      db.collection('timeline').document(data.toString()).setData({
        'name': username,
        'profilepic': profileurl,
        'statusphoro': null,
        'statuscontent': content,
        'Time': data,
        'uid': uid
      });
      EdgeAlert.show(
        context,
        title: 'Uploaded',
        gravity: EdgeAlert.TOP,
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => timeline(
                    email: email,
                    name: username,
                    photourl: profileurl,
                  )));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitHourGlass(
        color: Colors.blue,
      ),
    );
  }
}
