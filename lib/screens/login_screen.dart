import 'package:alrabb/database/methods.dart';
import 'package:alrabb/pages/home_page.dart';
import 'package:alrabb/screens/create_account.dart';
import 'package:alrabb/screens/home_screen.dart';
import 'package:alrabb/widgets/routing_page.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              // ignore: sized_box_for_whitespace
              child: Container(
                height: size.height / 20,
                width: size.width / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height / 20),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 1.2,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 1.3,
                    child: const Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: size.width / 1.3,
                    child: const Text(
                      "Login to continue",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 10),
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: size.width,
                    child: field(size, "email", Icons.account_box, _email),
                  ),
                  // ignore: sized_box_for_whitespace
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: size.width,
                      child: field(size, "password", Icons.lock, _password),
                    ),
                  ),
                  SizedBox(height: size.height / 10),
                  customButton(size),
                  SizedBox(height: size.height / 20),
                  GestureDetector(
                    onTap: () {
                      RoutingPage.goToNext(
                          widget: const CreateAccount(), context: context);
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    // ignore: sized_box_for_whitespace
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          logIn(_email.text, _password.text).then((user) {
            if (user != null) {
              // ignore: avoid_print
              print("Login seccessful");
              setState(() {
                isLoading = false;
              });
              RoutingPage.goToNext(widget: HomePage(), context: context);
            } else {
              // ignore: avoid_print
              print("Login Failed");
            }
          });
        } else {
          // ignore: avoid_print
          print("Login failed");
        }
      },
      child: Container(
        height: size.height / 10,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: size.height / 15,
      width: size.width / 1.2,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
