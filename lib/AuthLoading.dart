import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Blocs/UserBloc.dart';
import 'package:myapp/Pages/Login_Page/Login_form.dart';
import 'package:myapp/Pages/home/Home.dart';
import 'package:myapp/SharedPreference/SharedPref.dart';


import 'Blocs/AuthBloc.dart';

class AuthLoading extends StatefulWidget {
  @override
  _AuthLoadingState createState() => _AuthLoadingState();
}

class _AuthLoadingState extends State<AuthLoading> {
  var auth = "load";

  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.of<UserBloc>(context);
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    print('this is build widget');

    return BlocBuilder<AuthBloc, AuthStates>(builder: (context, state) {
      if (state is AUTH_LOADING) {
        return Container(
          child: Center(child: Text("Splash Screen")),
        );
      } else if (state is AUTH_AUTHERIZED) {
        return HomePage();
      } else {
        return LoginForm();
      }
    });
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final _userBloc = BlocProvider.of<UserBloc>(context);
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    SharedPref sharedPref = SharedPref();
    final userData = await sharedPref.read("userData");
    print('this is local data $userData');

    if (mounted) {
      if (userData != null) {
        _userBloc.add(SETDATA(data: json.decode(userData)));
        _authBloc.add(AUTHERIZED_EVENT());
      } else {
        _authBloc.add(NOTAUTHERIZED_EVENT());
      }
    }
  }
}
