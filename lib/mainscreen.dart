import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample_project/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './main.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final nameController = TextEditingController();

  late SharedPreferences logindata;
  late String username;
  // late SharedPreferences registerdata;
  String name = '';
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = logindata.getString('email') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        title: const Text("Main Screen"),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(name),
            const SizedBox(),
            Image.network(
                "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
            const SizedBox(
              width: 20,
              height: 20,
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'register',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 50,
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  primary: Colors.deepPurple,
                ),
                onPressed: () {
                  // if (name != '') {
                  //   print('success');
                  // }
                  setState(() {
                    name = nameController.text;
                  });
                },
                child: const Text('save form')),
            const SizedBox(
              width: 20,
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  primary: Colors.deepPurple,
                ),
                onPressed: () async {
                  logindata.setBool('login', true);
                  logindata.setBool('logedIn', false);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainContainer()));
                },
                child: const Text('log out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
