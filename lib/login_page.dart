import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sample_project/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  String email = 'abc@gmail.com';
  String password = '123456';
  late String finalEmail;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }


  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formkey,
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                  ),
                  labelText: 'Enter Email',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: "Required **"),
                  EmailValidator(errorText: "Wrong Email"),
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    labelText: "Enter Password",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    )),
                validator: MultiValidator([
                  RequiredValidator(errorText: "Required **"),
                  MinLengthValidator(6,
                      errorText: "Password should be at least 6 characters"),
                  MaxLengthValidator(6, errorText: "Invalid password")
                ]),
              ),
              const Padding(padding: EdgeInsets.all(20.0)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    if (emailController.text == "abc@gmail.com" &&
                        passwordController.text == '123456') {
                      String email = emailController.text;
                      String password = passwordController.text;
                        print('Success');
                        logindata.setBool('login', false);
                        logindata.setBool('logedIn', true);
                        logindata.setString('email', emailController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()));
                      }
                    }

                  },
                child: const Text('login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
