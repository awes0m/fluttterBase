import 'package:flutter/material.dart';
import 'package:flutter_base/net/flutterfire.dart';
import 'package:flutter_base/util_constants.dart';

import 'home_screen.dart';

class Authentication extends StatefulWidget {
  static var routeName = '/authentication';
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool shouldNavigate = false;

  //email and password
  //email Controller
  final TextEditingController _emailController = TextEditingController();
  //password Controller
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScrnSizer.screenWidth(context),
        height: ScrnSizer.screenHeight(context),
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        //Authentication Form
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Email Field
            Container(
              width: ScrnSizer.screenWidth(context) / 1.3,
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                //email field hence email controller
                style: const TextStyle(color: Colors.white),
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'yourEmail@email.com',
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: ScrnSizer.screenHeight(context) / 35),
            //Password Field
            Container(
              width: ScrnSizer.screenWidth(context) / 1.3,
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                //password field hence password controller
                style: const TextStyle(color: Colors.white),

                controller: _passwordController,
                //blocks the charected right after typing(for password entries)
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: ScrnSizer.screenHeight(context) / 35),

            //Register Button
            Container(
              width: ScrnSizer.screenWidth(context) / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: MaterialButton(
                child: const Text('Register'),
                onPressed: () async {
                  bool shouldNavigate = await register(
                      _emailController.text, _passwordController.text);
                  if (shouldNavigate) {
                    //Navigate to Home Page
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }
                },
              ),
            ),
            SizedBox(height: ScrnSizer.screenHeight(context) / 35),

            //Login Button
            Container(
              width: ScrnSizer.screenWidth(context) / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate = await signIn(
                      _emailController.text, _passwordController.text);
                  if (shouldNavigate) {
                    //Navigate to Home Page
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
