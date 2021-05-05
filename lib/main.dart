import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:testpp/auth/auth.dart';
import 'package:testpp/service/read.dart';
import 'package:testpp/service/timeline.dart';
import 'package:testpp/signuo.dart';
import 'package:testpp/uplodere.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slidebar',
      home: myhomescreen(),
    );
  }
}

class myhomescreen extends StatefulWidget {
  @override
  _myhomescreenState createState() => _myhomescreenState();
}

class _myhomescreenState extends State<myhomescreen> {
  final db = Firestore.instance;
  final Authservice _authservice = Authservice();
  String user;
  String password;
  bool hidentext = true;
  Icon ves = Icon(
    Icons.visibility,
    size: 17,
  );
  void hidenpassword() {
    print('hello');
    if (hidentext == true) {
      hidentext = false;
      setState(() {
        ves = Icon(
          Icons.visibility_off,
          size: 17,
        );
      });
    } else {
      hidentext = true;
      setState(() {
        ves = Icon(
          Icons.visibility,
          size: 17,
        );
      });
    }
  }

  GlobalKey<FormState> _key = new GlobalKey();
  bool autoval = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            //first layer
            Container(
              color: Colors.blue,
            ),
            //second layer
            Container(
              margin: EdgeInsets.only(top: 130),
              decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(100))),
            ),
            Container(
              margin: EdgeInsets.only(top: 140),
              decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(100))),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 150),
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(100))),
            ),

            Container(
              margin: EdgeInsets.only(top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 180),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 280,
                          height: 300,
                          margin: EdgeInsets.only(top: 10),
                          child: Form(
                            key: _key,
                            autovalidate: autoval,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: EmailValidator(
                                      errorText:
                                          'Enter the valid Email address'),
                                  onChanged: (value) {
                                    setState(() {
                                      user = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.person),
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return 'Please Enter the password';
                                    } else if (value.length < 4) {
                                      return 'Your password contain more then 5 Character';
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  obscureText: hidentext,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    suffix: InkWell(
                                      onTap: hidenpassword,
                                      child: ves,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 340),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(30)),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              if (_key.currentState.validate()) {
                                dynamic res = await _authservice.signWithEmail(
                                    user, password);
                                print(res);

                                if (res == null) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                                'Please Enter Valid Email or Password'),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Okay'))
                                            ],
                                          ));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => reader(
                                                uid: res,
                                              )));
                                }
                                return SpinKitCircle(
                                  color: Colors.blue,
                                );
                              } else {
                                autoval = true;
                              }
                            },
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't Have an Account?"),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signup()));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.blue),
                        ),
                        minWidth: 10,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
