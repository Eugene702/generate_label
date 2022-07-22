import 'package:flutter/material.dart';
import 'package:generate_label/home.dart';

class Login extends StatelessWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final username = TextEditingController();
    final password = TextEditingController();

    const _username = "nieng.thya";
    const _password = "kookie01";

    void login(){
      username.text == _username && password.text == _password ? Navigator.push(context, MaterialPageRoute(builder: (context) => const Home())) : showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Failed"),
          content: const Text("Username or Password is incorrect"),
          actions: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context)
            )
          ]
        )
      );
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 300.0,
              child: TextFormField(
                controller: username,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_rounded),
                  labelText: "Username",
                  hintText: "Input Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  )
                ),
              ),
            ),
          ),

          const SizedBox(height: 20.0),

          SizedBox(
            width: 300.0,
            child: TextFormField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.key_rounded),
                labelText: "Password",
                hintText: "Input Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                )
              ),
            ),
          ),

          const SizedBox(height: 20.0),

          SizedBox(
            width: 300.0,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.login_rounded, size: 25.0,),
              label: const Text("Login", style: TextStyle(fontSize: 25.0),),
              onPressed: login,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}