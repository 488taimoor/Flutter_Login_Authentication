import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Blocs/AuthBloc.dart';
import 'package:myapp/Services/Service.dart';
import 'package:myapp/SharedPreference/SharedPref.dart';
import 'package:myapp/env.dart';
import 'package:myapp/Blocs/UserBloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _loginfomrkey =  GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _loading = false;
  String _errMsg= "";
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _phoneController = new TextEditingController();

  String validatePassword(String value) {
    if (value.length < 3)
      return 'Password must be more than 2 charater';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
//    if (value.length != 10)
//      return 'Mobile Number must be of 10 digit';
//    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }




  onChangeEmail(value){
    print('this is onchange email $value');
  }
  @override
  Widget build(BuildContext context) {

    final _authBloc = BlocProvider.of<AuthBloc>(context);
    final _userBloc = BlocProvider.of<UserBloc>(context);



    _validateInputs() {
      setState(() {
        _loading=true;
      });
      print("this is environment variables ${environment["baseUrl"]}");
      if(_loginfomrkey.currentState.validate()) {
        print("these are values ${_emailController.text}, ${_passwordController.text}, ${_phoneController.text}");
        _loginfomrkey.currentState.save();
        final Object data= {"phoneNumber":_phoneController.text, "password":_passwordController.text, "fcmToken":"this is fcm token", "timezone":"Asia/Karachi" };
        print("this is login detail on press $data");
        PostAPI(data, environment["baseUrl"]+"login").then((onValue) async {
          print("this is result $onValue");
          if(onValue["status"]==200){
            SharedPref sharedPref = SharedPref();
            final userData = await sharedPref.save("userData",onValue);
            print("this is user Data $userData $onValue");
            _userBloc.add(SETDATA(data: onValue));
            _authBloc.add(AUTHERIZED_EVENT());
            setState(() {
              _errMsg="";
              _loading=false;
            });
          }else{
            setState(() {
              _errMsg=onValue['message'];
              _loading=false;
            });
          }
        }).catchError((onError){
          print("this is error $onError");
            });

//      _loginBloc.add(API_CALL(data:data));
      }else{
        setState(() {
          _autoValidate=true;
        });
//      }

    }
    }
    return Container(
      padding: EdgeInsets.all(40),
      child: Form(
        key: _loginfomrkey,
        autovalidate: _autoValidate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            TextFormField(
//              decoration: InputDecoration(labelText: "Email"),
//              validator: validateEmail,
//              controller: _emailController,
//              keyboardType: TextInputType.emailAddress,
//              onChanged: onChangeEmail,
//            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Phone Number"),
              validator: validateMobile,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Password"),
              validator: validatePassword,
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
            ),

            Row(
              children: <Widget>[
                _errMsg!=""?
                Text(_errMsg, style: TextStyle(color: Colors.red,),):Container( width: 0, height: 0,)

              ],
            ),
            new SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: _validateInputs,
              child: _loading? Text("Loading..."):Text("Validate")
            )
          ],
        ),
      )
    );
  }
}
