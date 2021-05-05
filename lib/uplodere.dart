import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testpp/auth/userdata.dart';
import 'package:testpp/service/timeline.dart';
import 'package:testpp/uploader/timelineupload.dart';

class reader extends StatefulWidget {
  String uid;
  reader({this.uid});
  @override
  _readerState createState() => _readerState(uid: uid);
}

class _readerState extends State<reader> {
  final db = Firestore.instance;
  String uid;
  _readerState({this.uid});
  String name;
  String email;
  String photourl;
  Userdetails _userdetails = Userdetails.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection(uid)
              .document('profile')
              .collection('pofile_details')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  name = ds['name'];
                  email = ds['email'];
                  photourl = ds['Photourl'];

                  _userdetails.saveid(uid);
                  _userdetails.savename(name);
                  _userdetails.saveemail(email);
                  _userdetails.saveurl(photourl);

                  //
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 150),
                      child: Column(
                        children: [
                          Text(
                            'Welcome Back !',
                            style: TextStyle(fontSize: 40, color: Colors.blue),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(30)),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => timeline(
                                                name: name,
                                                email: email,
                                                photourl: photourl,
                                              )));
                                },
                              )),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return ListTile(
                title: Text('No data'),
              );
            }
          }),
    );
  }
}
