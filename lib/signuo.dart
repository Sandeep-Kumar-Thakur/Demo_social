import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:testpp/auth/auth.dart';
import 'package:testpp/service/timeline.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:testpp/uploader/photo_uploader.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  File _image;
  final picker = ImagePicker();
  String name;
  String email;
  String password;
  Authservice _authservice = Authservice();
  String imageLink;
  final db = Firestore.instance;
  var pickedFile;
  final PhotoUploader _photoUploader = PhotoUploader();
  GlobalKey<FormState> _key = new GlobalKey();

  Future getImage(source) async {
    pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile == null) {
      } else {
        _image = File(pickedFile.path);
      }
    });
  }

  Widget addphoto() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.add_a_photo), Text('Add a photo')]);
  }

  String repassword;
  bool autoval = false;
  bool passwordmatch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 500,
                width: 300,
                child: SingleChildScrollView(
                  child: Form(
                    key: _key,
                    autovalidate: autoval,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => RichAlertDialog(
                                        alertType: RichAlertType.WARNING,
                                        alertTitle: Text(
                                          'Profile Picture',
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        alertSubtitle: Text('Upload from'),
                                        actions: [
                                          FlatButton(
                                              onPressed: () {
                                                getImage(ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Camra')),
                                          FlatButton(
                                              onPressed: () {
                                                getImage(ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Gallery'))
                                        ],
                                      ));
                            },
                            child: Container(
                                width: 100,
                                height: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: _image == null
                                      ? addphoto()
                                      : Image.file(_image),
                                )),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            String pattern = r'^(?=.*?[A-Z]).{1,}$';
                            RegExp regExp = new RegExp(pattern);
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            } else if (!regExp.hasMatch(value)) {
                              return 'First letter must be capital';
                            } else if (value.length <= 3) {
                              return 'Your name must be contain 4 letter';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: InputDecoration(hintText: 'Name'),
                        ),
                        TextFormField(
                          validator:
                              EmailValidator(errorText: 'Enter valid email'),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: InputDecoration(hintText: 'Email'),
                        ),
                        TextFormField(
                          validator: (value) {
                            String pattern1 = r'^(?=.*?[a-z0-9]).{5,}$';
                            String pattern2 =
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                            RegExp regExp = new RegExp(pattern1);
                            if (!regExp.hasMatch(value)) {
                              return 'Your Password must have 5 character';
                            } else {
                              passwordmatch = true;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(hintText: 'Password'),
                        ),
                        TextFormField(
                          validator: (value1) {
                            if (value1 != password) {
                              return 'Password not matched';
                            }
                          },
                          decoration:
                              InputDecoration(hintText: 'Re-Enter Password'),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              if (_key.currentState.validate()) {
                                print('hello');
                                dynamic uid = await _authservice
                                    .signWithNewEmail(email, password);
                                if (uid == null) {
                                  print('Uid is null');
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PhotoUploader(
                                                uid: uid,
                                                file: _image,
                                                name: name,
                                                email: email,
                                              )));
                                }
                              } else {
                                autoval = true;
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
