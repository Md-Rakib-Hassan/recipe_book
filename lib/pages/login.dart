import 'package:flutter/material.dart';
import 'package:recipe_book/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _loginFormKey= GlobalKey();
  String? username,password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: SafeArea(
          child: _UI(),
      ) ,
    );
  }

  Widget _UI(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginForm(),
        ],
      ),
    );
}
  Widget _title(){
    return Text("Recipe Book", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),);
  }

  Widget _loginForm(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width*.9,
      height: MediaQuery.sizeOf(context).height*.3,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: "kminchelle",
              onSaved: (value){
                setState(() {
                  username=value;
                });
              },
              validator: (value){
                if(value==null || value.isEmpty){
                  return "Enter a username";
                }
              },
              decoration: InputDecoration(hintText: "User Name"),
            ),
            TextFormField(
              initialValue: "0lelplR",
              obscureText: true,
              onSaved: (value){
                setState(() {
                  password=value;
                });
              },
              validator: (value){
                if(value==null || value.length<5){
                  return "Enter a valid password";
                }
              },
              decoration: InputDecoration(hintText: "Password"),
            ),
            _loginButton(),
          ],
        ),
      )
    );
  }

  Widget _loginButton(){
    return SizedBox(
      child: ElevatedButton(
        onPressed: ()async{
          if(_loginFormKey.currentState?.validate()?? false){
            _loginFormKey.currentState?.save();
            bool result =await AuthService().login(username!, password!);
            if(result){
              Navigator.pushReplacementNamed(context, '/home');
            }
            else{
              StatusAlert.show(context, duration: const Duration(seconds: 3),
              title: "Login Failed",
                subtitle: "Please try again",
                configuration: const IconConfiguration(
                  icon: Icons.error,
                ),
                maxWidth: 260
              );
            }
          }

        },
        child: Text("Login"),
      ),
    );
  }
}