import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class read extends StatefulWidget {
  @override
  _readState createState() => _readState();
}

class _readState extends State<read> {
  String username;
  String content;
  String profileurl;
  String contenturl;
  String time;
  final db = Firestore.instance;

  Widget withoutphoto(String contentx) {
    return Container(
        height: 100, child: Center(child: Text('"' + contentx + '"')));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: db
              .collection('timeline')
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
                  profileurl = ds['profilepic'];
                  contenturl = ds['statusphoro'];

                  print(username);
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
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
                          height: 65,
                          padding: EdgeInsets.only(bottom: 2),
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, -1))
                          ]),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 10),
                                width: 50,
                                height: 50,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
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

                        // withoutcontent(contenturl),

                        (contenturl != null && content != null)
                            ? withphoto(content, contenturl)
                            : (contenturl == null)
                                ? withoutphoto(content)
                                : withoutcontent(contenturl)

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
                title: Text('No data'),
              );
            }
          },
        ),
      ),
    );
  }
}
