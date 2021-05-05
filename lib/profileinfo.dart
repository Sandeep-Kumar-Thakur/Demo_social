import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testpp/auth/userdata.dart';

class profiledetails extends StatefulWidget {
  @override
  _profiledetailsState createState() => _profiledetailsState();
}

class _profiledetailsState extends State<profiledetails> {
  Userdetails _userdetails = Userdetails.instance;
  String name;
  String email;
  String profileurl;
  String uid;
  String username;
  String profileurle;
  String content;
  String contenturl;
  Future getdata() async {
    name = await _userdetails.username;
    email = await _userdetails.userEmail;
    uid = await _userdetails.userid;
    profileurl = await _userdetails.profileurl;
    setState(() {});
  }

  Widget withoutphoto(String contentx) {
    return Container(
        height: 100, child: Center(child: Text('"' + contentx + '"')));
  }

  Widget withoutcontent(String contenturl) {
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        width: 340,
        // height: 280,
        child: Column(
          children: [
            Container(
                width: 340,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                  child: Image.network(
                    contenturl,
                    //fit: BoxFit.cover,
                  ),
                ))
          ],
        ),
      )
    ]));
  }

  Widget withphoto(String contenty, contenturrl) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            width: 340,
            // height: 280,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('"' + content + '"'),
                  ],
                ),
                Container(
                    width: 340,
                    height: 180,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                      child: Image.network(
                        contenturl,
                        //fit: BoxFit.cover,
                      ),
                    ))
              ],
            ),
          ),
          // Container(
          //     width: 340,
          //     height: 180,
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          //       child: Image.network(
          //         contenturl,
          //         fit: BoxFit.cover,
          //       ),
          //     ))
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
  }

  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 360,
              height: 230,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.blue,
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, -2))
              ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(profileurl),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Email : ',
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text(email)
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'User id : ',
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text(uid)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 400,
              child: StreamBuilder(
                stream: db
                    .collection('timeline')
                    .where('uid', isEqualTo: uid)
                    .orderBy('Time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.documents[index];
                        username = ds['name'];
                        content = ds['statuscontent'];
                        profileurle = ds['profilepic'];
                        contenturl = ds['statusphoro'];

                        print(username);
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                          width: 200,
                          // height: 342,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 2.0, // soften the shadow
                                    spreadRadius: 1.0,
                                    offset: Offset(5.0, 5.0)),
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 2.0, // soften the shadow
                                    spreadRadius: 1.0,
                                    offset: Offset(-5.0, -5.0))
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                width: 340,
                                height: 70,
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      width: 60,
                                      height: 70,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.network(profileurl)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      username,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              (contenturl != null && content != null)
                                  ? withphoto(content, contenturl)
                                  : (contenturl == null)
                                      ? withoutphoto(content)
                                      : withoutcontent(contenturl),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        db
                                            .collection('timeline')
                                            .document(ds.documentID)
                                            .delete();
                                      })
                                ],
                              )
                              // Container(
                              //     width: 340,
                              //     height: 180,
                              //     child: ClipRRect(
                              //       borderRadius: BorderRadius.vertical(
                              //           bottom: Radius.circular(20)),
                              //       child: Image.network(
                              //         contenturl,
                              //         fit: BoxFit.cover,
                              //       ),
                              //     ))
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListTile(
                      title: Text('No Updates'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
