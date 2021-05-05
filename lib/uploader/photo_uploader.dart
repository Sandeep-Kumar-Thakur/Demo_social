import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PhotoUploader extends StatefulWidget {
  String uid;
  String name;
  String email;
  File file;
  PhotoUploader({this.uid, this.file, this.name, this.email});
  @override
  _PhotoUploaderState createState() =>
      _PhotoUploaderState(uid: uid, file: file, namea: name, emaila: email);
}

class _PhotoUploaderState extends State<PhotoUploader> {
  String uid;
  File file;
  String namea;
  String emaila;
  String url;
  _PhotoUploaderState({this.uid, this.file, this.namea, this.emaila});
  final db = Firestore.instance;
  final FirebaseStorage _firebaseStorage =
      FirebaseStorage(storageBucket: 'gs://timeline-f3f37.appspot.com/');
  StorageUploadTask _storageUploadTask;
  StorageTaskSnapshot _storageTaskSnapshot;

  //upload data

  Future upload() async {
    String filepath = 'profile/$uid.png';
    _storageUploadTask = _firebaseStorage.ref().child(filepath).putFile(file);
    _storageTaskSnapshot = await _storageUploadTask.onComplete;
    url = await _storageTaskSnapshot.ref.getDownloadURL();
    print(namea);
    print(emaila);
    setState(() {
      db
          .collection(uid)
          .document('profile')
          .collection('pofile_details')
          .add({'name': namea, 'email': emaila, 'Photourl': url});
      print(url);
    });
    EdgeAlert.show(context,
        title: 'Thanks for Register',
        description: 'Please login ',
        gravity: EdgeAlert.TOP);
    Navigator.pop(context);
  }

  @override
  void initState() {
    upload();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StorageTaskEvent>(
      stream: _storageUploadTask.events,
      builder: (_, snapshort) {
        var event = snapshort?.data?.snapshot;
        return _storageUploadTask.isComplete
            ? SpinKitWave(
                color: Colors.blue,
              )
            : SpinKitWave(
                color: Colors.blue,
              );
      },
    );
  }
}
