import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:testpp/uploader/newupload.dart';
import 'package:testpp/uploader/timelineupload.dart';

class Write extends StatefulWidget {
  @override
  _WriteState createState() => _WriteState();
}

class _WriteState extends State<Write> {
  File file;
  Future getimage(var source) async {
    var image = await ImagePicker().getImage(source: source);
    setState(() {
      if (image == null) {
      } else {
        file = File(image.path);
      }
    });
  }

  Widget addphoto() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add,
          color: Colors.blue,
        ),
        Text(
          "Add Photo",
          style: TextStyle(color: Colors.blue),
        )
      ],
    );
  }

  String status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 340,
            height: 430,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    status = value;
                  },
                  maxLines: 10,
                  maxLength: 200,
                  decoration: InputDecoration(border: new OutlineInputBorder()),
                ),
                Container(
                  width: 340,
                  height: 100,
                  child: Row(
                    children: [
                      Container(
                        width: 170,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DottedBorder(
                              color: Colors.blue,
                              dashPattern: [5, 5, 5, 5],
                              child: Container(
                                width: 100,
                                height: 100,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => RichAlertDialog(
                                              alertTitle: Text('Choose'),
                                              alertSubtitle:
                                                  Text('upload image'),
                                              alertType: RichAlertType.WARNING,
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      getimage(
                                                          ImageSource.camera);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Camra')),
                                                FlatButton(
                                                    onPressed: () {
                                                      getimage(
                                                          ImageSource.gallery);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Gallary'))
                                              ],
                                            ));
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: file == null
                                        ? addphoto()
                                        : Image.file(file),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: 170,
                          height: 100,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    splashColor: Colors.green,
                                    elevation: 100,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(color: Colors.blue)),
                                    onPressed: () {
                                      if (file == null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    withoutphoto(
                                                      content: status,
                                                    )));
                                      } else {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    timeupload(
                                                      status: status,
                                                      image: file,
                                                    )));
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Send',
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons.send,
                                          color: Colors.blue,
                                        )
                                      ],
                                    ),
                                    minWidth: 140,
                                  )
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
