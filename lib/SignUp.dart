import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  static void signUp(String email, String password) async {
    try {
      Response response = await post(Uri.parse("https://reqres.in/api/register"),
          body: {"email": email, "password": password});
      if (response.statusCode == 200) {
        print("ApI successfully called");
      } else {
        print("request failedd");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Sign up"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'enter your email',
                    labelText: 'Email *',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'enter your password',
                    labelText: 'Password *',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                  onTap: () => {
                        signUp(emailController.text.toString(),
                            passwordController.text.toString())
                      },
                  child: Container(
                    color: Colors.green,
                    height: 50,
                    child: Center(
                      child: Text("signup"),
                    ),
                  )),
            )
          ],
        )));
  }
}
