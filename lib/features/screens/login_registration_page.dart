import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter/features/controllers/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});




  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  String? errorMessage = '';
  bool isLogin = true;


  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerfName = TextEditingController();
  final TextEditingController _controllerlName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerRetypePassword = TextEditingController();

  Future<void> signInWithEmailAndPassword()async{
    bool isValid = _formKey.currentState!.validate();
    if (!isValid){
      return;
    }
    try{
      await Auth().signInWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  Future<void> createUserWithEmailAndPassword()async{
    bool isValid = _formKey.currentState!.validate();
    if (!isValid){
      return;
    }
    try{
      UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
      //CONFIRM IF CORRECT
      await http.post(Uri.parse('${dotenv.env["LOCALHOST_URL"]}/users'),
          headers: {'Content-Type': 'application/json'},
          body:jsonEncode({
          'email': _controllerEmail.text,
          'userId': userCredential.user?.uid,
          'name': '${_controllerfName.text} ${_controllerlName.text}'
        })


      );

    } on FirebaseAuthException catch(e) {
      setState((){errorMessage = e.message;});
    }
  }

  Widget _title(){
    return const Text('Firebase Auth');
  }
  Widget _entryField(String title,
      TextEditingController controller,
      TextEditingController ? valController,
      bool passField) {
    String ? _validate(String ? val) {
      String ? valText = valController?.text;
      String error = '';
      if (val == null) {
        return 'Please Type a Password';
      }
      else if (!isLogin && valText == null) {
        return 'Please Retype your Password';
      }
      else if (!isLogin && val.length < 6) {
        return 'Password must be at least 6 letters';
      }
      else if (!isLogin && val != valText) {
        return 'Passwords must match';
      }
      return null;
    }

    if (passField) {
      return TextFormField(controller: controller,
          decoration: InputDecoration(labelText: title),
          obscureText: passField,
          validator: (val) => _validate(val),
          onChanged: (message) {
            if (errorMessage != '') {
              setState(() {
                errorMessage = '';
              });
            }
          });
    }
    else {
      return TextFormField(controller: controller,
          decoration: InputDecoration(labelText: title),
          obscureText: passField,
          onChanged: (error) {
            if (errorMessage != '') {
              setState(() {
                errorMessage = '';
              });
            }
          });
    }
  }

  Widget _errorMessage(){
    return  Text(errorMessage =='' ? '': '$errorMessage');
  }

  Widget _submitButton(){

    return ElevatedButton(
      onPressed: () =>isLogin ? signInWithEmailAndPassword(): createUserWithEmailAndPassword(),
      child: Text(isLogin ? 'Login': 'Register'),
    );
  }

  Widget _loginOrRegisterButton(){
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register Instead': 'Login Instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: _title(),
        ),
        body:Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                    key:_formKey,
                    child:
                    Column(
                      children: [

                        Visibility(visible: !isLogin,child:Column(children: [_entryField('first name', _controllerfName,null, false),
                          _entryField('last name', _controllerlName,null, false),
                          _entryField('email', _controllerEmail,null, false),
                          _entryField('password', _controllerPassword, _controllerRetypePassword, true),
                          _entryField('retype password', _controllerRetypePassword, _controllerPassword, true)],
                    )),
                        Visibility(visible: isLogin,child:Column(children: [
                          _entryField('email', _controllerEmail,null, false),
                          _entryField('password', _controllerPassword, _controllerRetypePassword, true),
                        ],
                        ))],
                    )
                )
                ,_errorMessage(),
                _submitButton(),
                _loginOrRegisterButton()],
            )
        )
    );
  }
  }

