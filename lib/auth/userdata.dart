import 'package:flutter/foundation.dart';

class Userdetails {
  String userid;
  String username;
  String userEmail;
  String profileurl;

  // Userdetails obj = new Userdetails();
  Userdetails._privateconstructor();
  static final Userdetails instance = Userdetails._privateconstructor();

  Future saveid(String uid) async {
    userid = await uid;
  }

  Future savename(String name) async {
    username = await name;
  }

  Future saveemail(String email) async {
    userEmail = await email;
  }

  Future saveurl(String url) async {
    profileurl = await url;
  }

  Future getuid() async {
    print('Data : ');
    print(userid);
    return userid;
  }

  Future getname() async {
    return username;
  }

  Future getemail() async {
    return userEmail;
  }

  Future getphotourl() async {
    return profileurl;
  }
}
