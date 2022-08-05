import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample_project/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './mainscreen.dart';

void main() {
  runApp(Test());
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("App Bar"),
        ),
        body: MainContainer(),
      )
    );
  }
}

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key}) : super(key: key);

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  void check_if_already_login() async {
    var logindata = await SharedPreferences.getInstance();
    var newuser = logindata.getBool('logedIn');
    if(newuser == false) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
    }
    // if (newuser == false) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => const MainScreen()));
    // }
  }
  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("This is the name of the file and the otehra;ldbhhal;l"),
        )
      ),
    );
  }
}
