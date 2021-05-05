import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testpp/auth/userdata.dart';
import 'package:testpp/service/timeline.dart';

class timeupload extends StatefulWidget {
  String status;
  File image;
  timeupload({this.image, this.status});
  @override
  _timeuploadState createState() =>
      _timeuploadState(status: status, image: image);
}

class _timeuploadState extends State<timeupload> {
  String status;
  File image;

  _timeuploadState({this.status, this.image});
  String name;
  String profilepic;
  String uid;
  String timelinephotourl;
  String email;
  final data = new DateTime.now();

  Userdetails _userdetails = Userdetails.instance;
  final db = Firestore.instance;
  final FirebaseStorage _firebaseStorage =
      FirebaseStorage(storageBucket: 'gs://timeline-f3f37.appspot.com/');
  StorageUploadTask _storageUploadTask;
  StorageTaskSnapshot _storageTaskSnapshot;

  Future getdata() async {
    name = await _userdetails.username;
    profilepic = await _userdetails.profileurl;
    uid = await _userdetails.userid;
    email = await _userdetails.userEmail;
    String path = '$data';

    _storageUploadTask = _firebaseStorage.ref().child(path).putFile(image);
    _storageTaskSnapshot = await _storageUploadTask.onComplete;
    timelinephotourl = await _storageTaskSnapshot.ref.getDownloadURL();
    setState(() {
      db.collection("timeline").document(data.toString()).setData({
        'name': name,
        'profilepic': profilepic,
        'statusphoro': timelinephotourl,
        'statuscontent': status,
        'Time': data,
        'uid': uid
      });
      //     .collection('Timeline')
      //     .document('time')
      //     .collection(data.toString())
      //     .add({
      //   'name': name,
      //   'profilepic': profilepic,
      //   'statusphoro': timelinephotourl,
      //   'statuscontent': status,
      //   'Time': data
      // });
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
                    name: name,
                    photourl: profilepic,
                  )));
    });
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitCubeGrid(
        color: Colors.blue,
      ),
    ));
  }
}
